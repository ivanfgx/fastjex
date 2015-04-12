class PaymentsController < ApplicationController
  require 'date'
  require 'paypal-sdk-adaptivepayments'
  require 'rest_client'
  require "pp-adaptive"
  require 'json'

  def check_for_payments
    end
  def test
    result = PaymentSchedule.new
    result = result.pay(User.last, PaymentSchedule.last)
    render json: result
  end

  def pay
    payment = PaymentSchedule.find(params[:id])
    @api = PayPal::SDK::AdaptivePayments.new

    # Build request object
    @pay = @api.build_pay({
      :actionType => "PAY",
      :cancelUrl => "http://localhost:3000/samples/adaptive_payments/pay",
      :currencyCode => "MXN",
      :senderEmail => payment.user.email,
      :ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
      :memo => "Nomina",
      :receiverList => {
        :receiver => [{
          :amount => payment.amount,
          :email => payment.account }] },
      :returnUrl => "http://localhost:3000/samples/adaptive_payments/pay" })

    # Make API call & get response
    @response = @api.pay(@pay)

    # Access response
    if @response.success? && @response.payment_exec_status != "ERROR"
      @response.payKey
      redirect_to @api.payment_url(@response)  # Url to complete payment
    else
      @response.error[0].message
      render json: @response
    end
    
  end

  def subscription
    #PA-2BS25581P84232213
    payment = PaymentSchedule.find(params[:id]);
    client = AdaptivePayments::Client.new(
      :user_id       => "dude_api1.hotmail.es",
      :password      => "WC89FAW4E6N5PEKA",
      :signature     => "AFcWxV21C7fd0v3bYYYRCpSSRl31ACwd6g7hhhBCeUn.ndSBp5HmqJIl",
      :app_id        => "APP-80W284485P519543T",
      :sandbox       => true
    )

    client.execute(:Pay,
      :preapproval_key => payment.pak,
      :action_type     => "PAY",
      :receiver_email  => payment.account,
      :receiver_amount => payment.amount,
      :currency_code   => "MXN",
      :memo => "Nomina",
      :cancel_url      => "https://lvh.me:3000/cancel",
      :return_url      => "https://lvh.me:3000/"
    ) do |response|

      if response.success?
        puts "Pay key: #{response.pay_key}"
        puts "Status: #{response.payment_exec_status}"
      else
        puts "#{response.ack_code}: #{response.error_message}"
      end
      @response = response
      @resJSON =  response.to_json
      render :succeed
    end
  end

  def preapprovalkey
    payment = PaymentSchedule.find(params[:id])

    client = AdaptivePayments::Client.new(
      :user_id       => "dude_api1.hotmail.es",
      :password      => "WC89FAW4E6N5PEKA",
      :signature     => "AFcWxV21C7fd0v3bYYYRCpSSRl31ACwd6g7hhhBCeUn.ndSBp5HmqJIl",
      :app_id        => "APP-80W284485P519543T",
      :sandbox       => true
    )

    client.execute(:Preapproval,
      :ending_date      => payment.end_date,
      :starting_date    => payment.start_date,
      :max_total_amount => BigDecimal("1999.00"),
      :currency_code    => "MXN",
      :memo => "Nomina",
      :cancel_url       => "http://lvh.me:3000/cancelled",
      :return_url       => "http://lvh.me:3000/subs/"+params[:id]
    ) do |response|
      # you may alternatively pass a PreapprovalRequest instance

      if response.success?
        puts "Preapproval key: #{response.preapproval_key}"

        # send the user to PayPal to give their approval
        # e.g. https://www.paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=abc
        payment.pak = response.preapproval_key
        payment.save
        redirect_to client.preapproval_url(response)
        
      else
        puts "#{response.ack_code}: #{response.error_message}"
        render json: response
      end

    end
  end
end
