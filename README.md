Wrapped Rails
-------------

This gem is for Rails coders who hate 500 pages.

Is that you? Listen up.

You sometimes write things like this:

    class User < ActiveRecord::Base
      validates_presence_of :first_name, :last_name

      def common_name
        "#{first_name} #{middle_name.first}. #{last_name}"
      end
    end

And it works awesomely for your test user:

    class UserTest < ActiveRecord::TestCase
      def test_common_name
        user = User.new(:first_name => 'Roy',
                        :middle_name => 'Gabriel',
                        :last_name => 'Biv')
        asset_equal "Roy G. Biv", user.common_name
      end
    end

So you push to production, and then you get this exception in your Airbrake
log, pointing to line 3 of user.rb

    NoMethodError: undefined method `first' for nil:NilClass

Now since you firmly believe that it is inexcusable, in these modern times, for
a piece of software to crash, you fix it ASAP, with the appropriate test:

    class UserTest < ActiveRecord::TestCase
      def test_common_name_without_middle_name
        user = User.new(:first_name => 'The',
                        :middle_name => nil,
                        :last_name => 'Pope')
        asset_equal "The Pope", user.common_name
      end
    end

    class User < ActiveRecord::Base
      validates_presence_of :first_name, :last_name

      def common_name
        [first_name,
         "#{middle_initial}.",
         last_name].join(' ')
      end

      def middle_initial
        middle_name.try(:first) || 'Q'
      end
      protected :middle_initial
    end

But all the whiling you're thinking, "How did I miss that?" Moreover, you
ruminate on the fact that `first_name` and `last_name` are required fields but
`middle_name` is not. Obviously you need to use `try` _everywhere_ you access
the `middle_name` column.

So now you need a test that checks that you are calling `try` whereever you
access the `middle_name` field.

Clearly there's a problem here, and this problem is that the `middle_name`
field makes it too easy to screw up. You want to catch these issues earlier.
You want that initial test to be like "oh hey whoa I know this works but you
really should check for nil you know?"

_So you use this gem_.

    class User < ActiveRecord::Base
      validates_presence_of :first_name, :last_name

      def common_name
        [first_name,
         "#{middle_initial}.",
         last_name].join(' ')
      end

      def middle_initial
        middle_name.unwrap_or('Q') {|mn| mn.first }
      end
      protected :middle_initial
    end

So what? Did we just rename `try` to `unwrap_or` and bake the `||` into it?

No. We did something more.

That `middle_name` is always wrapped now. You have to ask for the value. In a
sense, you _must_ call `try` on it, only instead of `try` we're going to use
`unwrap_or` because that knows what to do if it's nil.

So there, now you're happy, not just because your code is more clear but also
because your panicked coworkers won't accidentally use a middle name without
checking if it's `nil` all in the name of some arbitrary deadline.

Is That All?
------------

This gem uses the `wrapped` gem underneath, which can do a whole lot more than
just `unwrap_or`. Check it out for the details.

Copyright
---------
Copyright 2011 Mike Burns
