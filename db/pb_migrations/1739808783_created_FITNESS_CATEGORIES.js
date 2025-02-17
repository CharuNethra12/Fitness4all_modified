/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = new Collection({
    "createRule": "",
    "deleteRule": "",
    "fields": [
      {
        "autogeneratePattern": "[a-z0-9]{15}",
        "hidden": false,
        "id": "text3208210256",
        "max": 15,
        "min": 15,
        "name": "id",
        "pattern": "^[a-z0-9]+$",
        "presentable": false,
        "primaryKey": true,
        "required": true,
        "system": true,
        "type": "text"
      },
      {
        "hidden": false,
        "id": "select1756795826",
        "maxSelect": 1,
        "name": "NAME",
        "presentable": false,
        "required": false,
        "system": false,
        "type": "select",
        "values": [
          "weight",
          "sleep",
          "calories",
          "exercise",
          "steps",
          "distance",
          "time"
        ]
      }
    ],
    "id": "pbc_3184048540",
    "indexes": [],
    "listRule": "",
    "name": "FITNESS_CATEGORIES",
    "system": false,
    "type": "base",
    "updateRule": "",
    "viewRule": ""
  });

  return app.save(collection);
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3184048540");

  return app.delete(collection);
})
