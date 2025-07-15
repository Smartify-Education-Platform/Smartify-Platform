import json

# Списки допустимых значений
ALLOWED_INTERESTS = [
    "Помогать людям",
    "Разрабатывать технологии",
    "Делать эксперименты и исследования",
    "Общаться и вести переговоры",
    "Работать с цифрами и данными",
    "Организовывать проекты",
    "Писать и читать",
    "Делать что-то руками",
    "Художественное творчество",
    "Путешествия и международные связи",
]

ALLOWED_VALUES = [
    "Высокий доход",
    "Стабильность",
    "Помощь другим",
    "Самореализация",
    "Свобода",
    "Карьерный рост",
    "Работа в команде",
    "Удалённая работа",
]

ALLOWED_ROLES = [
    "Руководитель",
    "Исследователь и стратег",
    "Исполнитель",
    "Вдохновитель и коммуникатор",
]

ALLOWED_PLACES = [
    "В лаборатории",
    "В переговорной комнате",
    "На стройке или в мастерской",
    "За компьютером",
]

ALLOWED_STYLES = [
    "По чёткому алгоритму",
    "Спонтанно, в зависимости от ситуации",
]

# Загрузка исходного файла
with open("database/professions.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# Функция для попытки найти близкий аналог по части ключевого слова
def find_closest(value, allowed_list):
    for allowed in allowed_list:
        if value.lower() in allowed.lower() or allowed.lower() in value.lower():
            return allowed
    return None

# Проверка и исправление
for prof in data:
    # interests
    fixed_interests = []
    for interest in prof.get("interests", []):
        if interest in ALLOWED_INTERESTS:
            fixed_interests.append(interest)
        else:
            alt = find_closest(interest, ALLOWED_INTERESTS)
            if alt:
                fixed_interests.append(alt)
    prof["interests"] = fixed_interests

    # values
    fixed_values = []
    for value in prof.get("values", []):
        if value in ALLOWED_VALUES:
            fixed_values.append(value)
        else:
            alt = find_closest(value, ALLOWED_VALUES)
            if alt:
                fixed_values.append(alt)
    prof["values"] = fixed_values

    # role
    if prof.get("role") not in ALLOWED_ROLES:
        alt = find_closest(prof["role"], ALLOWED_ROLES)
        prof["role"] = alt if alt else ""

    # place
    if prof.get("place") not in ALLOWED_PLACES:
        alt = find_closest(prof["place"], ALLOWED_PLACES)
        prof["place"] = alt if alt else ""

    # style
    if prof.get("style") not in ALLOWED_STYLES:
        alt = find_closest(prof["style"], ALLOWED_STYLES)
        prof["style"] = alt if alt else ""

# Сохраняем новую версию
with open("database/professions_fixed.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print("Готово! Новый файл сохранён как 'professions_fixed.json'")
