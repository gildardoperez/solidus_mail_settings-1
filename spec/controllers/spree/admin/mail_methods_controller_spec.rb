describe Spree::Admin::MailMethodsController, type: :controller do
  stub_authorization!

  let!(:store) { create(:store) }

  context '#update' do
    it 'reinitializes the mail settings' do
      spree_put :update, enable_mail_delivery: '1'
      expect(response).to be_redirect
    end
  end

  it 'can trigger testmail' do
    user = create(:user, email: 'user@spree.com')
    allow(controller).to receive(:try_spree_current_user).and_return(user)
    Spree::Config[:enable_mail_delivery] = '1'

    expect {
      spree_post :testmail
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
end
