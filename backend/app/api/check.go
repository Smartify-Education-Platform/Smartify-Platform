package api

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/IU-Capstone-Project-2025/Smartify/backend/app/auth"
)

// @Summary      Проверка доступности сервера
// @Description  Возвращает статус "ok" если сервер работает
// @Tags         utils
// @Produce      json
// @Success      200 {object} Success_answer "Сервер доступен"
// @Failure      405 {object} Error_answer   "Метод не разрешен"
// @Router       /hello [get]
func HelloHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		w.WriteHeader(http.StatusMethodNotAllowed)
		json.NewEncoder(w).Encode(Error_answer{
			Error: "Method not allowed",
			Code:  http.StatusMethodNotAllowed,
		})
		return
	}

	log.Println("New check")

	response := Success_answer{
		Status: "ok",
		Code:   http.StatusOK,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}

// @Summary      Проверка валидности токенов
// @Description  Проверяет срок действия access и refresh токенов
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        tokens  body      Tokens_answer  true  "Пара токенов для проверки"
// @Success      200     {object}  Success_answer "Токены валидны"
// @Failure      400     {object}  Error_answer   "Невалидный запрос"
// @Failure      401     {object}  Error_answer   "Токены невалидны или просрочены"
// @Failure      405     {object}  Error_answer   "Метод не разрешен"
// @Router       /checkTokens [post]
func TokenCheck(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		w.WriteHeader(http.StatusMethodNotAllowed)
		json.NewEncoder(w).Encode(Error_answer{
			Error: "Method not allowed",
			Code:  http.StatusMethodNotAllowed,
		})
		return
	}

	var tokens Tokens_answer
	// Декодируем json сообщение
	err := json.NewDecoder(r.Body).Decode(&tokens)
	if err != nil {
		log.Println("Cannot decode request")
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(Error_answer{
			Error: "Code does not equal...",
			Code:  http.StatusBadRequest,
		})
		return
	}

	err = auth.ValidateRefreshToken(tokens.RefreshToken)
	if err != nil {
		log.Println("Refresh token is old: " + err.Error())
		w.WriteHeader(http.StatusUnauthorized)
		json.NewEncoder(w).Encode(Error_answer{
			Error: "Refresh Token is old",
			Code:  http.StatusUnauthorized,
		})
		return
	}

	err = auth.ValidateAccessToken(tokens.AccessToken)
	if err != nil {
		log.Println("Access token is old: " + err.Error())
		w.WriteHeader(http.StatusUnauthorized)
		json.NewEncoder(w).Encode(Error_answer{
			Error: "Access Token is old",
			Code:  http.StatusUnauthorized,
		})
		return
	}

	response := Success_answer{
		Status: "ok",
		Code:   http.StatusOK,
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}
