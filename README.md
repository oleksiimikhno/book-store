# Bookstore only-API

## We used:
- ruby '3.2.2'
- rails '7.1.2'
- active_model_serializers
- jwt
- rswag
- administrate
- rspec-rails
- ffaker
- factory_bot_rails
- pundit
- paranoia

#### You can see [local swagger endpoints](http://127.0.0.1:3000/api-docs/index.html) 


What to use gem paranoia.

If you want to find all records, even those which are deleted:

```User.with_deleted```

If you want to exclude deleted records, when not able to use the default_scope:

```User.without_deleted```

If you want to find only the deleted records:

```User.only_deleted```