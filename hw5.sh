/*
        Написать запрос, который выводит общее число тегов
*/
print("tags count: ", db.tags.count());
/*
        Добавляем фильтрацию: считаем только количество тегов woman
*/
print("woman tags count: ", db.tags.count({'name': 'woman'}));
/*
        Очень сложный запрос: используем группировку данных посчитать количество вхождений для каждого тега
        и напечатать top-3 самых популярных
*/

printjson(
        db.tags.aggregate([
               {"$group": {
                              _id: "$name",
                               tags: {$sum:1}
         }
               },{$sort:{"tags": -1}},
               {$limit: 3}
       ])['_batch']
);
