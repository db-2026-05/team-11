# TEAMWORK - Topic 11 (Database Administration)

## Склад команди
- Команда: 11
- Варіант предметної області: Fitness Center Management

## Таблиця внесків
| Учасник | Роль у команді | Що зроблено | Артефакти / файли |
| Ihor Tsiupka | SQL Developer | Section 1: REVOKE defaults, Section 2: CREATE ROLES, Section 3: GRANT CONNECT |https://www.loom.com/share/37a83bf7db6a4d0b8baeac21f4f95004|
| Lisovyk Anastasia | SQL Developer | Section 4: Schema-level permissions (USAGE, CREATE), Section 5: Table-level GRANT для app_readonly | ... |
| Heiko Mykola | SQL Developer | Section 5: GRANT для app_readwrite та app_admin, Section 6: REVOKE (TRUNCATE, DML) | ... |
| Mykhailo Lukianiuk | SQL Developer + Tester | Section 7: CREATE USER + GRANT ROLE, Section 8: Cleanup block, фінальне тестування файлу | (https://www.loom.com/share/1849f74ac13042088f96d88ca9701396%20-%2011%20тема) |

## Контекст теми
Опишіть, хто відповідав за: створення ролей і користувачів, GRANT/REVOKE, логіку least privilege, тестування прав доступу та optional cleanup у database_administration.sql.

Коротке обґрунтування командного підходу
Чому обрали саме такі ролі та рівні доступу: Фітнес-центр має три чіткі категорії користувачів — аналітики (лише читають дані про членів та розклад), бекенд-сервіс (записує бронювання, оновлює прогрес членів) та адміністратор БД (керує структурою). Кожній категорії відповідає окрема роль з мінімально необхідними правами.
Як розподілили відповідальність за безпекову модель: Кожен учасник отримав логічно пов'язані секції скрипту. Ihor заклав основу (ролі та підключення), Anastasia і Mykola розподілили між собою рівні прав (schema та table level), Mykhailo завершив модель реальними користувачами та перевірив цілісність.
Як перевірили, що ролі реально відрізняються правами: Mykhailo запустив повний скрипт у PostgreSQL та перевірив права через системний запит \dp (показує права на таблиці) і \du (показує ролі та користувачів). Кожен учасник вручну перевіряв свої секції після написання.
