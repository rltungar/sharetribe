module PaypalService

  class Onboarding

    OnboardingParameters = EntityUtils.define_builder(
      [:partnerId, :mandatory, :string],
      [:returnToPartnerUrl, :mandatory, :string],
      [:merchantId, transform_with: -> (_) { SecureRandom.uuid }],
      [:partnerLogoUrl, :string],
      [:countryCode, :string],
      [:productIntentID, const_value: "addipmt"],
      [:integrationType, const_value: "T"],
      [:permissionsNeeded, const_value: "EXPRESS_CHECKOUT,AUTH_CAPTURE,REFUND,REFERENCE_TRANSACTION,TRANSACTION_DETAILS,EXPRESS_CHECKOUT,ACCESS_BASIC_PERSONAL_DATA"],
      [:displayMode, const_value: "Regular"],
      [:showPermissions, const_value: "TRUE"])

    def initialize(config)
      @config = config
    end

    def create_onboarding_link(opts)
      params = OnboardingParameters.call(opts.merge({partnerId: config[:partner_id]}))
      params.merge({ redirect_url: UrlUtils.build_url(base_path(config[:endpoint]), params) })
    end


    private

    def base_path(endpoint)
      if endpoint[:endpoint_name] == "sandbox"
        "https://www.sandbox.paypal.com/webapps/merchantboarding/webflow/externalpartnerflow"
      else
        raise ArgumentError.new("Unknown endpoint type: #{endpoint}")
      end
    end

  end
end
