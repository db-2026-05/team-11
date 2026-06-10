# TEAMWORK - Topic 10 (SQL Views)

## Склад команди
- Команда: 11
- Варіант предметної області: Fitness Center Management

## Таблиця внесків
| Учасник | Роль у команді | Що зроблено | Артефакти / файли |
| Ihor Tsiupka | SQL Developer | Horizontal view (view_members_names), Vertical view (view_active_members) |  https://www.loom.com/share/9a4bb217d3f94a7d89222c2eac458acd |
| Lisovyk Anastasia | SQL Developer | Mixed view (view_premium_members), CHECK OPTION view (view_monthly_members) | --- |
| Heiko Mykola | SQL Developer | Join view (view_class_timetable), Subquery view (view_members_with_completed_classes) | --- |
| Mykhailo Lukianiuk | SQL Developer + Tester | UNION view (view_all_activities), Layered view (view_morning_classes), фінальне тестування файлу | --- |

## Контекст теми
Опишіть, хто відповідав за: horizontal/vertical/mixed views, join/subquery/UNION views, view-from-view, `WITH CHECK OPTION`, а також demo-`SELECT` і структуру `views.sql`.

## Коротке обгрунтування командного підходу
1. Як ви розподілили типи views між учасниками: Кожен учасник отримав 2 views схожої складності. Ihor відповідав за базові horizontal та vertical views, Anastasia — за mixed та CHECK OPTION views (обидва пов'язані з фільтрацією членів), Mykola — за join та subquery views як найскладніші технічно, Mykhailo — за UNION та layered view, а також фінальне зведення файлу.
2. Чому ці views важливі для предметної області: Фітнес-центр постійно працює з даними про членів, розклад та тренерів. Views дозволяють швидко отримувати потрібну інформацію — наприклад, які заняття заплановані, хто з членів активний, або які тренування відбуваються вранці — без повторного написання складних запитів.
3. Як перевіряли практичну цінність і коректність кожного view: Кожен учасник виконував SELECT на своїх views після створення та перевіряв результат вручну. Mykhailo фінально запустив увесь скрипт у PostgreSQL та перевірив, що всі views створюються без помилок і повертають очікувані дані.