class PagesController < ApplicationController
  def show
    render action: params.fetch(:page)
  end

  # Respond to Let's Encrypt "ACME Challenge"
  def letsencrypt
    render plain: "LJTr0vqRH88nZxt41CNFzU5w3JQBm8dFjdkZje_dYfM.Y7UPp_ppTTi7qxod_OP_OAD2T0JPRTKodTuqCc3txrM"
  end
end
