Rails.application.routes.draw do
  draw(:administrators)
  draw(:user)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
