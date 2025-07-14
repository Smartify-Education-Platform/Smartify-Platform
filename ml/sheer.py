import json
from collections import defaultdict

# Загрузим файл профессий
with open("database/professions.json", "r", encoding="utf-8") as f:
    professions = json.load(f)

# Считаем общее количество профессий
total_count = len(professions)

# Группируем по сферам и подсферам
spheres = defaultdict(lambda: defaultdict(list))

for prof in professions:
    sphere = prof.get("sphere", "Не указано")
    subsphere = prof.get("subsphere", "Не указано")
    spheres[sphere][subsphere].append(prof["name"])

# Сохраняем статистику в JSON
stats = {
    "total_professions": total_count,
    "spheres": []
}

for sphere, subspheres in spheres.items():
    for subsphere, prof_list in subspheres.items():
        stats["spheres"].append({
            "sphere": sphere,
            "subsphere": subsphere,
            "count": len(prof_list),
            "professions": prof_list
        })

with open("database/spheres_stats.json", "w", encoding="utf-8") as f:
    json.dump(stats, f, ensure_ascii=False, indent=2)