module SpecHelpers
  def stub_session
    controller.session.stub(:[]).with("flash")
    controller.session.stub(:[]).with(:_turbolinks_redirect_to)
    controller.session.stub(:[]).with(:user_id).and_return 1
  end
end
