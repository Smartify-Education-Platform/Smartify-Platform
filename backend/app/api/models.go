package api

type Success_answer struct {
	Status string `json:"status"`
	Code   int    `json:"code"`
}

type Error_answer struct {
	Error string `json:"error"`
	Code  int    `json:"code"`
}

type Tokens_answer struct {
	RefreshToken string `json:"refresh_token"`
	AccessToken  string `json:"access_token"`
}

type Code_verification struct {
	Email string `json:"email"`
	Code  string `json:"code"`
}

type Update_password struct {
	Email       string `json:"email"`
	NewPassword string `json:"newPassword"`
}

type User_email_password struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type Refresh_token struct {
	RefreshToken string `json:"refresh_token"`
}

type Email_struct struct {
	Email string `json:"email"`
}

type Tutor_succes struct {
	Status string `json:"status"`
	Code   int    `json:"code"`
}
