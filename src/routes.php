<?php

require "routes/dashboard.php";
require "routes/page.php";
require "routes/fileManager.php";
require "routes/auth.php";
require "routes/blog.php";
require "routes/widget.php";
require "routes/menu.php";
require "routes/user.php";
require "routes/settings.php";
require "routes/brands.php";
require "routes/error.php";
require "routes/message.php";
require "routes/subscribers.php";
require "routes/frontend.php"; // to be last so the route does not shadow the rest << regex gotcha >>
