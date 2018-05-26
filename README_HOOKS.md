## Defining hooks

The Hookable DSL features two main keywords that serve as the primary interface as well as a handful of keywords that add context.

* **before** - Used to start a before hook
* **after** - Used to start an after hook
* **call** - Used to indicate which method to call as part of the hook.  This can be a symbol, proc, or lambda.
* **with** - Used to provide arguments to the call.  Procs and lambdas can be supplied to resolve params at runtime.
* **using** - Used to indicate where the method to call "lives".  Again proc and lambdas can be supplied.  By default, the element is checked for the method to call as well as the page.

Putting those together we get something like:

```ruby
contacts_menu_hooks = define_hooks do
  before(:click).call(:ensure_visible).with(:contacts)
  after(:click).call(:wait_for_ajax)
end

link(:view_businesses, text: 'View Businesses', hooks: contacts_menu_hooks)
```

The the above code we can call `page.view_businesses` without first ensuring that the contacts menu has been made visible.  Likewise we know that `wait_for_ajax` will be called whenever the link is clicked.

Hooks can be combined via a merge method.  For example, assuming we have a common set of hooks defined as `WFA_HOOKS` that cover methods that are likely to trigger AJAX, the above could be written as:

```ruby
contacts_menu_hooks = define_hooks do
  before(:click).call(:ensure_visible).with(:contacts)
end

link(:view_businesses, text: 'View Businesses', hooks: contacts_menu_hooks.merge(WFA_HOOKS))
```

If you need access to element without hooks applied, such as when testing functionality covered by the hooks you can use the _unhooked method for the element.  
Using the above example the method would be view_businesses_unhooked