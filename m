Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E92C02199
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.9391.1738752390235943574
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:46:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=gm1 header.b=oQdm7Iwq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9873143428;
	Wed,  5 Feb 2025 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlfDxZlvpt3FTPzZYeK/PY/GGwTTXVfyHbKWR9Yk7o0=;
	b=oQdm7IwqKxUN9AkeyJ1ycsXk3oi7bbib9eeO7UTKKS2GmoEg4zpfvrIGdFocCTwEiIKGKF
	5SDQ8iP6HZCmMzUmsqcmFdyhTrWfkwB0/LuoAY/dnPft4XwPk6zeu7ynPyeGqyHX4FTK3u
	7sQmshBCc7kbzjh0dVtCFeb+MeWNTVvLoH1pJOg4bC6ZKblTCqNUE7TQSQ76vkU5jQxEPx
	lo+i85b4yQPEpr9vUfPnczoBX+PuDL5w951rAhquC57L0WwFMeTQbzVQNNkP0oMmJG3Gy1
	kwNMXeHcEfLN3gCt03hiMLi3kpcpUANOLF+2abFIQl4uI5RuXYJe406mkxliPg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:45:52 +0100
Subject: [PATCH yocto-autobuilder2 2/4] yocto_console_view: import
 console_view plugin from buildbot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-console_view_upgrade-v1-2-fc1194355870@bootlin.com>
References: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
In-Reply-To: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752387; l=238873;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=kmRlgFQZGZ9u/O9ptJTqTLJNYqRj0ZxEgmF45AN63j8=;
 b=oqNjuZ5whjHuY8TUc0AovYY7AzXeHJxHrR9TBAaRXhbpZRrTTEyz2Flgg4lhUz4AWy+BhIh4d
 qnG4Nyqm1GfAaXUK0fSft+OlKlaY/edMZES4PmD0zAGFc7GkZl/h0oW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueehgfduteetteekjeetgedvkeehhfdvjeffkeeugfeludeludfhhfdthfffgfeinecuffhomhgrihhnpehjshdrmhgrphdptghsshdrmhgrphdphihotghtohhprhhojhgvtghtrdhorhhgpdgsuhhilhgusghothdrnhgvthdpghhithhhuhgsrdgtohhmpdhsuhhgghgvshhtihhonhhsrdhmugdphihotghtohdrihhopdhfihhlthgvrhgvuggptghhrghnghgvshdrmhgrphdpihhtvghmshdrmhgrphdpjhhsohhnrdgsuhhilhguvghrshdptghhihhlughithgvmhhsrdhmrghppdgsuhhilhguvghrrdhnrghmvgdphigrrhhnphhkghdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehi
 eemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:46:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1036

Plugin changed a lot with the buildbot transition from angularjs to
reactjs: start our own plugin customisation from scratch.

This commit only copies sources from buildboot git, without any
modification.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/README.txt                      |   17 -
 .../__init__.py                                    |    9 +-
 yocto_console_view/package.json                    |   78 +-
 yocto_console_view/setup.py                        |   26 +-
 yocto_console_view/src/index.ts                    |   18 +
 .../src/module/builders.fixture.json               |    1 -
 yocto_console_view/src/module/console.tpl.jade     |   39 -
 yocto_console_view/src/module/main.module.js       |  496 ------
 yocto_console_view/src/module/main.module.spec.js  |  228 ---
 .../src/module/releaseselectorfield.directive.js   |   68 -
 .../src/module/releaseselectorfield.tpl.jade       |    5 -
 .../src/module/view/modal/modal.controller.js      |   22 -
 .../src/module/view/modal/modal.style.less         |    9 -
 .../src/module/view/modal/modal.tpl.jade           |    6 -
 .../src/module/yoctochangedetails.directive.js     |   21 -
 .../src/module/yoctochangedetails.tpl.jade         |   42 -
 yocto_console_view/src/styles/styles.less          |   89 -
 .../src/views/ConsoleView/ConsoleView.scss         |   38 +
 .../src/views/ConsoleView/ConsoleView.test.ts      |   97 ++
 .../src/views/ConsoleView/ConsoleView.tsx          |  541 ++++++
 yocto_console_view/test/main.coffee                |    2 -
 yocto_console_view/tsconfig.json                   |   27 +
 yocto_console_view/vite.config.ts                  |   64 +
 yocto_console_view/webpack.config.js               |   26 -
 yocto_console_view/yarn.lock                       | 1755 ++++++++++++++++++++
 yocto_console_view/yocto_console_view/VERSION      |    1 -
 .../yocto_console_view/static/scripts.js           |    2 -
 .../yocto_console_view/static/scripts.js.map       |    1 -
 .../yocto_console_view/static/styles.css           |   79 -
 .../yocto_console_view/static/styles.css.map       |    1 -
 30 files changed, 2611 insertions(+), 1197 deletions(-)

diff --git a/yocto_console_view/README.txt b/yocto_console_view/README.txt
deleted file mode 100644
index 9edac1fd595f..000000000000
--- a/yocto_console_view/README.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-This custom buildbot plugin does three things:
-
-* Replaces the "Console View" with our own "Yocto Console View"
-* Adds a yoctochangedetails element to customise the information we display about a build
-  (link to the code repository, link to error reporting for the build)
-* Add a custom field element, ReleaseSelector to the force build scheduler allowing 
-  us to customise the form input fields to allow auto population of fields for 
-  specific release branch combinations
-
-The plugin ships in compiled form along with its source code. The generated files are:
-
-yocto_console_view/static/*
-yocto_console_view/VERSION
-
-In order to build this plugin you need a buildbot development environment setup along
-with its dependencies. FIXME, add more info on building.
-
diff --git a/yocto_console_view/yocto_console_view/__init__.py b/yocto_console_view/buildbot_console_view/__init__.py
similarity index 76%
rename from yocto_console_view/yocto_console_view/__init__.py
rename to yocto_console_view/buildbot_console_view/__init__.py
index 5b1412e4cbfc..b776b9b2ae02 100644
--- a/yocto_console_view/yocto_console_view/__init__.py
+++ b/yocto_console_view/buildbot_console_view/__init__.py
@@ -14,13 +14,6 @@
 # Copyright Buildbot Team Members
 
 from buildbot.www.plugin import Application
-from buildbot.schedulers.forcesched import ChoiceStringParameter
 
 # create the interface for the setuptools entry point
-ep = Application(__name__, "Buildbot Console View UI")
-
-class ReleaseSelector(ChoiceStringParameter):
-
-    spec_attributes = ["selectors"]
-    type = "releaseselector"
-    selectors = None
\ No newline at end of file
+ep = Application(__package__, "Buildbot Console View plugin")
diff --git a/yocto_console_view/package.json b/yocto_console_view/package.json
index 3ba5cf18e2aa..5e05343c809e 100644
--- a/yocto_console_view/package.json
+++ b/yocto_console_view/package.json
@@ -1,25 +1,57 @@
 {
-    "name": "yocto-console-view",
-    "plugin_name": "console_view",
-    "private": true,
-    "main": "yocto_console_view/static/scripts.js",
-    "style": "yocto_console_view/static/styles.js",
-    "scripts": {
-        "build": "rimraf yocto_console_view/static && webpack --bail --progress --profile --env prod",
-        "build-dev": "rimraf yocto_console_view/static && webpack --bail --progress --profile --env dev",
-        "dev": "webpack --bail --progress --profile --watch --env dev"
-    },
-    "devDependencies": {
-        "angular-mocks": "^1.7.9",
-        "buildbot-build-common": ">0.1",
-        "lodash": "^4.17.11",
-        "rimraf": "^2.6.3"
-    },
-    "dependencies": {
-        "@uirouter/angularjs": "^1.0.15",
-        "angular": "^1.7.9",
-        "angular-animate": "^1.7.9",
-        "buildbot-data-js": ">0.1",
-        "guanlecoja-ui": ">0.1"
-    }
+  "name": "buildbot-console-view",
+  "private": true,
+  "type": "module",
+  "module": "buildbot_console_view/static/scripts.js",
+  "style": "buildbot_console_view/static/styles.css",
+  "scripts": {
+    "start": "vite",
+    "build": "vite build",
+    "build-dev": "vite build -m development",
+    "test": "vitest run",
+    "test-watch": "vitest --watch"
+  },
+  "eslintConfig": {
+    "extends": [
+      "react-app"
+    ]
+  },
+  "babel": {
+    "presets": [
+      "react-app"
+    ]
+  },
+  "peerDependencies": {
+    "axios": "~1.7.7",
+    "mobx": "^6.6.1",
+    "mobx-react": "^9.1.1",
+    "moment": "^2.29.4",
+    "react": "^18.2.0",
+    "react-dom": "^18.2.0",
+    "react-router-dom": "^6.3.0"
+  },
+  "devDependencies": {
+    "@vitejs/plugin-react": "~4.3.1",
+    "axios": "~1.7.7",
+    "axios-mock-adapter": "~2.0.0",
+    "buildbot-data-js": "link:../data-module",
+    "buildbot-plugin-support": "link:../plugin_support",
+    "buildbot-ui": "link:../ui",
+    "jsdom": "^25.0.0",
+    "mobx": "^6.6.1",
+    "mobx-react": "^9.1.1",
+    "moment": "^2.29.4",
+    "react": "^18.2.0",
+    "react-app-polyfill": "~3.0.0",
+    "react-bootstrap": "^1.6.5",
+    "react-dom": "^18.2.0",
+    "react-router-dom": "^6.3.0",
+    "sass": "^1.56.0",
+    "vite": "~5.4.3",
+    "vitest": "~2.0.5"
+  },
+  "license": "GPL-2.0",
+  "dependencies": {
+    "react-icons": "^5.3.0"
+  }
 }
diff --git a/yocto_console_view/setup.py b/yocto_console_view/setup.py
index 363469f9fa55..02e44dc41216 100644
--- a/yocto_console_view/setup.py
+++ b/yocto_console_view/setup.py
@@ -19,27 +19,31 @@ try:
     from buildbot_pkg import setup_www_plugin
 except ImportError:
     import sys
-    print("Please install buildbot_pkg module in order to install that package, or use the pre-build .whl modules available on pypi", file=sys.stderr)
+
+    print(
+        'Please install buildbot_pkg module in order to install that '
+        'package, or use the pre-build .whl modules available on pypi',
+        file=sys.stderr,
+    )
     sys.exit(1)
 
 setup_www_plugin(
-    name='yocto-console-view',
-    description='Yocto Project Console View plugin.',
-    author=u'Richard Purdie',
-    author_email=u'richard.purdie@linuxfoundation.org',
-    url='http://autobuilder.yoctoproject.org/',
-    packages=['yocto_console_view'],
+    name='buildbot-console-view',
+    description='Buildbot Console View plugin',
+    author='Pierre Tardy',
+    author_email='tardyp@gmail.com',
+    url='http://buildbot.net/',
+    packages=['buildbot_console_view'],
     package_data={
         '': [
             'VERSION',
-            'static/*'
+            'static/*',
+            'static/assets/*',
         ]
     },
     entry_points="""
         [buildbot.www]
         console_view = yocto_console_view:ep
     """,
-    classifiers=[
-        'License :: OSI Approved :: GNU General Public License v2 (GPLv2)'
-    ],
+    classifiers=['License :: OSI Approved :: GNU General Public License v2 (GPLv2)'],
 )
diff --git a/yocto_console_view/src/index.ts b/yocto_console_view/src/index.ts
new file mode 100644
index 000000000000..fa0781c88e9a
--- /dev/null
+++ b/yocto_console_view/src/index.ts
@@ -0,0 +1,18 @@
+/*
+  This file is part of Buildbot.  Buildbot is free software: you can
+  redistribute it and/or modify it under the terms of the GNU General Public
+  License as published by the Free Software Foundation, version 2.
+
+  This program is distributed in the hope that it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+  details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 51
+  Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+  Copyright Buildbot Team Members
+*/
+
+import './views/ConsoleView/ConsoleView';
diff --git a/yocto_console_view/src/module/builders.fixture.json b/yocto_console_view/src/module/builders.fixture.json
deleted file mode 100644
index c5a7c6270c35..000000000000
--- a/yocto_console_view/src/module/builders.fixture.json
+++ /dev/null
@@ -1 +0,0 @@
-{"builders":[{"builderid":1,"description":null,"masterids":[1],"name":"buildbot-job","tags":["job","buildbot"]},{"builderid":2,"description":null,"masterids":[1],"name":"buildbot","tags":["buildbot","trunk"]},{"builderid":3,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:pylint TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TESTS:pylint","TWISTED:latest","python:2.7"]},{"builderid":4,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:flake8 TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:flake8"]},{"builderid":5,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:isort TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:isort"]},{"builderid":6,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:docs TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest"
 ,"TWISTED:latest","python:2.7","TESTS:docs"]},{"builderid":7,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:coverage TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:coverage"]},{"builderid":8,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:js TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:js"]},{"builderid":9,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:smokes TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:smokes"]},{"builderid":10,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial TWISTED:14.0.2 python:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial","TWISTED:14.0.2"]},{"builderid":11,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial TWISTED:15.4.0 pyth
 on:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial","TWISTED:15.4.0"]},{"builderid":12,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:trial"]},{"builderid":13,"description":null,"masterids":[],"name":"buildbot DB_TYPE:sqlite SQLALCHEMY:latest TESTS:trial TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:trial","DB_TYPE:sqlite"]},{"builderid":14,"description":null,"masterids":[],"name":"buildbot DB_TYPE:mysql SQLALCHEMY:latest TESTS:trial TWISTED:latest python:2.7","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","python:2.7","TESTS:trial","DB_TYPE:mysql"]},{"builderid":15,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:0.8.0 TESTS:trial TWISTED:15.5.0 python:2.7","tags":["buildbot","python:2.7","TESTS:trial","SQLALCHEMY:0.8.0","TWISTED:15.5.0"]},{"builde
 rid":16,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial TWISTED:15.5.0 python:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial","TWISTED:15.5.0"]},{"builderid":17,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:10.2.0 python:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial_worker","TWISTED:10.2.0"]},{"builderid":18,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:11.1.0 python:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial_worker","TWISTED:11.1.0"]},{"builderid":19,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:12.2.0 python:2.7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial_worker","TWISTED:12.2.0"]},{"builderid":20,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:13.2.0 python:2
 .7","tags":["buildbot","SQLALCHEMY:latest","python:2.7","TESTS:trial_worker","TWISTED:13.2.0"]},{"builderid":21,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:14.0.2 python:2.6","tags":["buildbot","SQLALCHEMY:latest","TWISTED:14.0.2","TESTS:trial_worker","python:2.6"]},{"builderid":22,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial_worker TWISTED:15.4.0 python:2.6","tags":["buildbot","SQLALCHEMY:latest","TWISTED:15.4.0","TESTS:trial_worker","python:2.6"]},{"builderid":23,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:coverage TWISTED:trunk python:3.5","tags":["buildbot","SQLALCHEMY:latest","TESTS:coverage","TWISTED:trunk","python:3.5"]},{"builderid":24,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:flake8 TWISTED:trunk python:3.5","tags":["buildbot","SQLALCHEMY:latest","TESTS:flake8","TWISTED:trunk","python:3.5"]},{"builderid":25,"description":nul
 l,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:smokes TWISTED:latest python:3.5","tags":["buildbot","SQLALCHEMY:latest","TWISTED:latest","TESTS:smokes","python:3.5"]},{"builderid":26,"description":null,"masterids":[],"name":"buildbot SQLALCHEMY:latest TESTS:trial TWISTED:trunk python:3.6","tags":["buildbot","SQLALCHEMY:latest","TESTS:trial","TWISTED:trunk","python:3.6"]}],"meta":{"total":26}}
diff --git a/yocto_console_view/src/module/console.tpl.jade b/yocto_console_view/src/module/console.tpl.jade
deleted file mode 100644
index a38f10e9faf6..000000000000
--- a/yocto_console_view/src/module/console.tpl.jade
+++ /dev/null
@@ -1,39 +0,0 @@
-.console.no-select
-    .load-indicator(ng-hide='c.builds.$resolved && c.changes.$resolved && c.buildrequests.$resolved && c.buildsets.$resolved')
-        .spinner
-            i.fa.fa-circle-o-notch.fa-spin.fa-2x
-            p loading
-    div(ng-show="c.changes.$resolved && c.filtered_changes.length==0")
-        p No changes. Console view needs changesource to be setup, and
-            a(href="#changes") changes
-            | to be in the system.
-
-    table.table.table-striped.table-bordered(ng-hide="c.filtered_changes.length==0" ng-class="{'table-fixedwidth': c.isBigTable()}")
-        tr.first-row
-            th.row-header(ng-style="{'width': c.getRowHeaderWidth()}")
-                i.fa.fa-plus-circle.pull-left(ng-click='c.openAll()' uib-tooltip='Open information for all changes' uib-tooltip-placement='right')
-                i.fa.fa-minus-circle.pull-left(ng-click='c.closeAll()' uib-tooltip='Close information for all changes' uib-tooltip-placement='right')
-            th.column(ng-repeat="builder in c.builders")
-                span.builder(ng-style="{'margin-top': c.getColHeaderHeight()}")
-                    a(ng-href='#/builders/{{ builder.builderid }}'
-                      ng-bind='builder.name')
-        tr.tag_row
-            td.row-header
-            td(ng-repeat="buildergroup in c.buildergroups" colspan="{{buildergroup.colspan}}" ng-style="{'text-align': 'center'}")
-                | {{buildergroup.tag}}
-        tr(ng-repeat="change in c.filtered_changes | orderBy: ['-when_timestamp'] track by change.changeid")
-            td
-                yoctochangedetails(change="change")
-            td.column(ng-repeat="builder in change.builders" colspan="{{builder.colspan}}")
-                span(ng-repeat="build in builder.builds | orderBy: ['number']")
-                    script(type="text/ng-template" id="buildsummarytooltip")
-                        buildsummary(buildid="build.buildid" type="tooltip")
-                    span.badge-status(ng-if='build.buildid'
-                                      uib-tooltip-template="'buildsummarytooltip'"
-                                      tooltip-class="buildsummarytooltipstyle"
-                                      tooltip-placement="auto left-bottom"
-                                      tooltip-popup-delay="400"
-                                      tooltip-popup-close-delay="400"
-                                      ng-class="c.results2class(build, 'pulse')"
-                                      ng-click='c.selectBuild(build)')
-                        | {{ build.number }}
diff --git a/yocto_console_view/src/module/main.module.js b/yocto_console_view/src/module/main.module.js
deleted file mode 100644
index 70067802a0fe..000000000000
--- a/yocto_console_view/src/module/main.module.js
+++ /dev/null
@@ -1,496 +0,0 @@
-/*
- * decaffeinate suggestions:
- * DS101: Remove unnecessary use of Array.from
- * DS102: Remove unnecessary code created because of implicit returns
- * DS205: Consider reworking code to avoid use of IIFEs
- * DS207: Consider shorter variations of null checks
- * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
- */
-
-import 'angular-animate';
-import '@uirouter/angularjs';
-import 'guanlecoja-ui';
-import 'buildbot-data-js';
-
-class ConsoleState {
-    constructor($stateProvider, glMenuServiceProvider, bbSettingsServiceProvider) {
-
-        // Name of the state
-        const name = 'console';
-
-        // Menu configuration
-        glMenuServiceProvider.addGroup({
-            name,
-            caption: 'Yocto Console View',
-            icon: 'exclamation-circle',
-            order: 5
-        });
-
-        // Configuration
-        const cfg = {
-            group: name,
-            caption: 'Yocto Console View'
-        };
-
-        // Register new state
-        const state = {
-            controller: `${name}Controller`,
-            controllerAs: "c",
-            template: require('./console.tpl.jade'),
-            name,
-            url: `/${name}`,
-            data: cfg
-        };
-
-        $stateProvider.state(state);
-
-        bbSettingsServiceProvider.addSettingsGroup({
-            name: 'Console',
-            caption: 'Console related settings',
-            items: [{
-                type: 'integer',
-                name: 'buildLimit',
-                caption: 'Number of builds to fetch',
-                default_value: 200
-            }
-            , {
-                type: 'integer',
-                name: 'changeLimit',
-                caption: 'Number of changes to fetch',
-                default_value: 30
-            }
-            ]});
-    }
-}
-
-class Console {
-    constructor($scope, $q, $window, dataService, bbSettingsService, resultsService,
-        $uibModal, $timeout) {
-        this.onChange = this.onChange.bind(this);
-        this._onChange = this._onChange.bind(this);
-        this.matchBuildWithChange = this.matchBuildWithChange.bind(this);
-        this.makeFakeChange = this.makeFakeChange.bind(this);
-        this.$scope = $scope;
-        this.$window = $window;
-        this.$uibModal = $uibModal;
-        this.$timeout = $timeout;
-        angular.extend(this, resultsService);
-        const settings = bbSettingsService.getSettingsGroup('Console');
-        this.buildLimit = settings.buildLimit.value;
-        this.changeLimit = settings.changeLimit.value;
-        this.dataAccessor = dataService.open().closeOnDestroy(this.$scope);
-        this._infoIsExpanded = {};
-        this.$scope.all_builders = (this.all_builders = this.dataAccessor.getBuilders());
-        this.$scope.builders = (this.builders = []);
-        this.$scope.buildergroups = (this.buildergroups = []);
-        if (typeof Intl !== 'undefined' && Intl !== null) {
-            const collator = new Intl.Collator(undefined, {numeric: true, sensitivity: 'base'});
-            this.strcompare = collator.compare;
-        } else {
-            this.strcompare = function(a, b) {
-                if (a < b) {
-                    return -1;
-                }
-                if (a === b) {
-                    return 0;
-                }
-                return 1;
-            };
-        }
-
-        this.$scope.revmapping = (this.revmapping = {});
-        this.$scope.branchmapping = (this.branchmapping = {});
-
-        this.$scope.builds = (this.builds = this.dataAccessor.getBuilds({
-            property: ["yp_build_revision", "yp_build_branch", "reason", "publish_destination"],
-            limit: this.buildLimit,
-            order: '-started_at'
-        }));
-        this.changes = this.dataAccessor.getChanges({limit: this.changeLimit, order: '-changeid'});
-        this.$scope.fakechanges = (this.fakechanges = []);
-        this.buildrequests = this.dataAccessor.getBuildrequests({limit: this.buildLimit, order: '-submitted_at'});
-        this.buildsets = this.dataAccessor.getBuildsets({limit: this.buildLimit, order: '-submitted_at'});
-
-        this.builds.onChange = this.onChange;
-        this.changes.onChange = this.onChange;
-        this.buildrequests.onChange = this.onChange;
-        this.buildsets.onChange = this.onChange;
-
-        this.builds.onNew = build => {
-            let change = false;
-            let {
-                buildid
-            } = build;
-            if ((build.properties != null ? build.properties.yp_build_revision : undefined) != null) {
-                this.revmapping[build.buildid] = build.properties.yp_build_revision[0];
-                change = true;
-            }
-            if ((build.properties != null ? build.properties.yp_build_branch : undefined) != null) {
-                this.branchmapping[build.buildid] = build.properties.yp_build_branch[0];
-                change = true;
-            }
-            if ((!this.revmapping[buildid] || !this.branchmapping[buildid]) && !build.complete_at) {
-                build.getProperties().onChange = properties => {
-                    change = false;
-                    buildid = properties.endpoint.split('/')[1];
-                    if (!this.revmapping[buildid]) {
-                        const rev = this.getBuildProperty(properties[0], 'yp_build_revision');
-                        if (rev != null) {
-                            this.revmapping[buildid] = rev;
-                            change = true;
-                        }
-                    }
-                    if (!this.branchmapping[buildid]) {
-                        const branch = this.getBuildProperty(properties[0], 'yp_build_branch');
-                        if (branch != null) {
-                            this.branchmapping[buildid] = branch;
-                            change = true;
-                        }
-                    }
-                    if (change && (this.onchange_debounce == null)) {
-                        this.onchange_debounce = this.$timeout(this._onChange, 100);
-                    }
-                };
-            }
-            if (change && (this.onchange_debounce == null)) {
-                this.onchange_debounce = this.$timeout(this._onChange, 100);
-            }
-        };
-    }
-
-    getBuildProperty(properties, property) {
-        const hasProperty = properties && properties.hasOwnProperty(property);
-        if (hasProperty) { return properties[property][0]; } else { return null; }
-    }
-
-    onChange(s) {
-        // if there is no data, no need to try and build something.
-        if ((this.builds.length === 0) || (this.all_builders.length === 0) || !this.changes.$resolved ||
-                (this.buildsets.length === 0) || (this.buildrequests === 0)) {
-            return;
-        }
-        if ((this.onchange_debounce == null)) {
-            this.onchange_debounce = this.$timeout(this._onChange, 100);
-        }
-    }
-
-    _onChange() {
-        let build, change;
-        this.onchange_debounce = undefined;
-        // we only display builders who actually have builds
-        for (build of Array.from(this.builds)) {
-            this.all_builders.get(build.builderid).hasBuild = true;
-        }
-
-        this.sortBuildersByTags(this.all_builders);
-
-        if (this.changesBySSID == null) { this.changesBySSID = {}; }
-        if (this.changesByRevision == null) { this.changesByRevision = {}; }
-        for (change of Array.from(this.changes)) {
-            this.changesBySSID[change.sourcestamp.ssid] = change;
-            this.changesByRevision[change.revision] = change;
-            this.populateChange(change);
-        }
-        for (change of Array.from(this.fakechanges)) {
-            this.populateChange(change);
-        }
-
-        for (build of Array.from(this.builds)) {
-            this.matchBuildWithChange(build);
-        }
-
-        this.filtered_changes = [];
-
-        for (let ssid in this.changesBySSID) {
-            change = this.changesBySSID[ssid];
-            if (change.comments) {
-                change.subject = change.comments.split("\n")[0];
-            }
-            for (let builder of Array.from(change.builders)) {
-                if (builder.builds.length > 0) {
-                    this.filtered_changes.push(change);
-                    break;
-                }
-            }
-        }
-    }
-    /*
-     * Sort builders by tags
-     * Buildbot eight has the category option, but it was only limited to one category per builder,
-     * which make it easy to sort by category
-     * Here, we have multiple tags per builder, we need to try to group builders with same tags together
-     * The algorithm is rather twisted. It is a first try at the concept of grouping builders by tags..
-     */
-
-    sortBuildersByTags(all_builders) {
-        // first we only want builders with builds
-        let builder, builders, tag;
-        const builders_with_builds = [];
-        let builderids_with_builds = "";
-        for (let builder of Array.from(all_builders)) {
-            if (builder.hasBuild && builder.name != 'indexing') {
-                builders_with_builds.push(builder);
-                builderids_with_builds += `.${builder.builderid}`;
-            }
-        }
-
-        if (builderids_with_builds === this.last_builderids_with_builds) {
-            // don't recalculate if it hasn't changed!
-            return;
-        }
-
-        const builders_by_tags = {};
-        for (builder of Array.from(builders_with_builds)) {
-            if (builder.tags != null && builder.tags.length) {
-                for (tag of Array.from(builder.tags)) {
-                    if ((builders_by_tags[tag] == null)) {
-                        builders_by_tags[tag] = [];
-                    }
-                    builders_by_tags[tag].push(builder);
-                }
-            } else {
-                if ((builders_by_tags[''] == null)) {
-                    builders_by_tags[''] = [];
-                }
-                builders_by_tags[''].push(builder);
-            }
-        }
-
-        const self = this;
-        for (tag in builders_by_tags) {
-            builders_by_tags[tag].sort((a, b) => self.strcompare(a.name, b.name));
-        }
-        let buildergroups = [];
-        for (tag in builders_by_tags) {
-            if (tag != '') {
-                buildergroups.push({
-                    name: builders_by_tags[tag][0].name,
-                    tag: tag,
-                    builders: builders_by_tags[tag],
-                    colspan: builders_by_tags[tag].length
-                });
-            }
-        }
-        for (builder in builders_by_tags['']) {
-            buildergroups.push({
-                name: builders_by_tags[''][builder].name,
-                tag: '',
-                builders: [builders_by_tags[''][builder]],
-                colspan: 1
-            });
-        }
-
-        buildergroups.sort((a, b) => self.strcompare(a.name, b.name));
-
-        let sorted_builders = [];
-        for (let group in buildergroups) {
-            for (builder in buildergroups[group].builders) {
-                sorted_builders.push(buildergroups[group].builders[builder])
-            }
-        }
-
-        this.builders = sorted_builders;
-        this.buildergroups = buildergroups;
-        this.tag_lines = [];
-        return this.last_builderids_with_builds = builderids_with_builds;
-    }
-
-    /*
-     * fill a change with a list of builders
-     */
-    populateChange(change) {
-        change.builders = [];
-        change.buildersById = {};
-        for (let buildergroup of Array.from(this.buildergroups)) {
-            let builderg = {name: buildergroup.name, builds: [], builders: [], colspan: buildergroup.builders.length};
-            for (let builder of Array.from(buildergroup.builders)) {
-                builderg.builders.push(builder);
-                change.buildersById[builder.builderid] = builderg;
-            }
-            change.builders.push(builderg);
-        }
-    }
-    /*
-     * Match builds with a change
-     */
-    matchBuildWithChange(build) {
-        let change, oldrev, rev;
-        const buildrequest = this.buildrequests.get(build.buildrequestid);
-        if ((buildrequest == null)) {
-            return;
-        }
-        const buildset = this.buildsets.get(buildrequest.buildsetid);
-        if ((buildset == null)) {
-            return;
-        }
-
-        if (((build.properties != null ? build.properties.yp_build_revision : undefined) != null) || this.revmapping[build.buildid]) {
-            if ((build.properties != null ? build.properties.yp_build_revision : undefined) != null) {
-                rev = build.properties.yp_build_revision[0];
-            } else {
-                rev = this.revmapping[build.buildid];
-            }
-            change = this.changesByRevision[rev];
-            if ((change == null)) {
-                change = this.changesBySSID[rev];
-            }
-            if ((change == null)) {
-                change = this.makeFakeChange(rev, build.started_at, rev);
-                this.fakechanges.push(change)
-            }
-
-            change.caption = "Commit";
-            if ((build.properties != null ? build.properties.yp_build_branch : undefined) != null) {
-                change.caption = build.properties.yp_build_branch[0];
-            }
-            if (this.branchmapping[build.buildid]) {
-                change.caption = this.branchmapping[build.buildid];
-            }
-            change.revlink = "http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=" + rev;
-            change.errorlink = "http://errors.yoctoproject.org/Errors/Latest/?filter=" + rev + "&type=commit&limit=150";
-            let bid = build.buildid;
-            if ((buildset != null) && (buildset.parent_buildid != null)) {
-                bid = buildset.parent_buildid;
-            }
-            if ((build.properties != null ? build.properties.reason : undefined) != null) {
-                change.reason = build.properties.reason[0];
-            }
-            if ((build.properties != null ? build.properties.publish_destination : undefined) != null) {
-                change.publishurl = build.properties.publish_destination[0].replace("/srv/autobuilder/autobuilder.yoctoproject.org/", "https://autobuilder.yocto.io/");
-                change.publishurl = change.publishurl.replace("/srv/autobuilder/autobuilder.yocto.io/", "https://autobuilder.yocto.io/");
-            }
-
-        } else {
-            rev = `Unresolved Revision`;
-            if ((change == null)) {
-                change = this.changesBySSID[rev];
-            }
-            if ((change == null)) {
-                change = this.makeFakeChange(rev, build.started_at, rev);
-                change.caption = rev;
-               this.fakechanges.push(change)
-            }
-
-        }
-
-        if (build.builderid in change.buildersById) {
-            change.buildersById[build.builderid].builds.push(build);
-        }
-    }
-
-    makeFakeChange(revision, when_timestamp, comments) {
-        const change = {
-            revision,
-            changeid: revision,
-            when_timestamp,
-            comments
-        };
-        this.changesBySSID[revision] = change;
-        this.populateChange(change);
-        return change;
-    }
-    /*
-     * Open all change row information
-     */
-    openAll() {
-        return Array.from(this.filtered_changes).map((change) =>
-            (change.show_details = true));
-    }
-
-    /*
-     * Close all change row information
-     */
-    closeAll() {
-        return Array.from(this.filtered_changes).map((change) =>
-            (change.show_details = false));
-    }
-
-    /*
-     * Calculate row header (aka first column) width
-     * depending if we display commit comment, we reserve more space
-     */
-    getRowHeaderWidth() {
-        if (this.hasExpanded()) {
-            return 400;  // magic value enough to hold 78 characters lines
-        } else {
-            return 200;
-        }
-    }
-    /*
-     * Calculate col header (aka first row) height
-     * It depends on the length of the longest builder
-     */
-    getColHeaderHeight() {
-        let max_buildername = 0;
-        for (let builder of Array.from(this.builders)) {
-            max_buildername = Math.max(builder.name.length, max_buildername);
-        }
-        return Math.max(100, max_buildername * 3);
-    }
-
-    /*
-     *
-     * Determine if we use a 100% width table or if we allow horizontal scrollbar
-     * depending on number of builders, and size of window, we need a fixed column size or a 100% width table
-     *
-     */
-    isBigTable() {
-        const padding = this.getRowHeaderWidth();
-        if (((this.$window.innerWidth - padding) / this.builders.length) < 40) {
-            return true;
-        }
-        return false;
-    }
-    /*
-     *
-     * do we have at least one change expanded?
-     *
-     */
-    hasExpanded() {
-        for (let change of Array.from(this.changes)) {
-            if (this.infoIsExpanded(change)) {
-                return true;
-            }
-        }
-        return false;
-    }
-
-    /*
-     *
-     * display build details
-     *
-     */
-    selectBuild(build) {
-        let modal;
-        return modal = this.$uibModal.open({
-            template: require('./view/modal/modal.tpl.jade'),
-            controller: 'consoleModalController as modal',
-            windowClass: 'modal-big',
-            resolve: {
-                selectedBuild() { return build; }
-            }
-        });
-    }
-
-    /*
-     *
-     * toggle display of additional info for that change
-     *
-     */
-    toggleInfo(change) {
-        return change.show_details = !change.show_details;
-    }
-    infoIsExpanded(change) {
-        return change.show_details;
-    }
-}
-
-
-angular.module('yocto_console_view', [
-    'ui.router', 'ui.bootstrap', 'ngAnimate', 'guanlecoja.ui', 'bbData'])
-.config(['$stateProvider', 'glMenuServiceProvider', 'bbSettingsServiceProvider', ConsoleState])
-.controller('consoleController', ['$scope', '$q', '$window', 'dataService', 'bbSettingsService', 'resultsService', '$uibModal', '$timeout', Console]);
-
-require('./view/modal/modal.controller.js');
-require('./releaseselectorfield.directive.js');
-require('./yoctochangedetails.directive.js');
diff --git a/yocto_console_view/src/module/main.module.spec.js b/yocto_console_view/src/module/main.module.spec.js
deleted file mode 100644
index 5c5b6380d1d3..000000000000
--- a/yocto_console_view/src/module/main.module.spec.js
+++ /dev/null
@@ -1,228 +0,0 @@
-/*
- * decaffeinate suggestions:
- * DS101: Remove unnecessary use of Array.from
- * DS102: Remove unnecessary code created because of implicit returns
- * DS206: Consider reworking classes to avoid initClass
- * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
- */
-beforeEach(function() {
-    angular.mock.module(function($provide) {
-        $provide.service('$uibModal', function() { return {open() {}}; });
-    });
-    angular.mock.module(function($provide) {
-        $provide.service('resultsService', function() { return {results2class() {}}; });
-    });
-
-    // Mock bbSettingsProvider
-    angular.mock.module(function($provide) {
-        $provide.provider('bbSettingsService', (function() {
-            let group = undefined;
-            const Cls = class {
-                static initClass() {
-                    group = {};
-                }
-                addSettingsGroup(g) { return g.items.map(function(i) {
-                    if (i.name === 'lazy_limit_waterfall') {
-                        i.default_value = 2;
-                    }
-                    return group[i.name] = {value: i.default_value};
-                }); }
-                $get() {
-                    return {
-                        getSettingsGroup() {
-                            return group;
-                        },
-                        save() {}
-                    };
-                }
-            };
-            Cls.initClass();
-            return Cls;
-        })()
-        );
-    });
-    angular.mock.module('yocto_console_view');
-});
-
-describe('Console view', function() {
-    let $state = null;
-    beforeEach(inject($injector => $state = $injector.get('$state'))
-    );
-
-    it('should register a new state with the correct configuration', function() {
-        const name = 'console';
-        const state = $state.get().pop();
-        const { data } = state;
-        expect(state.controller).toBe(`${name}Controller`);
-        expect(state.controllerAs).toBe('c');
-        expect(state.url).toBe(`/${name}`);
-    });
-});
-
-describe('Console view controller', function() {
-    // Test data
-
-    let $rootScope, $timeout, $window, dataService, scope;
-    let builders = [{
-        builderid: 1,
-        masterids: [1]
-    }
-    , {
-        builderid: 2,
-        masterids: [1]
-    }
-    , {
-        builderid: 3,
-        masterids: [1]
-    }
-    , {
-        builderid: 4,
-        masterids: [1]
-    }
-    ];
-
-    const builds1 = [{
-        buildid: 1,
-        builderid: 1,
-        buildrequestid: 1
-    }
-    , {
-        buildid: 2,
-        builderid: 2,
-        buildrequestid: 1
-    }
-    , {
-        buildid: 3,
-        builderid: 4,
-        buildrequestid: 2
-    }
-    , {
-        buildid: 4,
-        builderid: 3,
-        buildrequestid: 2
-    }
-    ];
-
-    const builds2 = [{
-        buildid: 5,
-        builderid: 2,
-        buildrequestid: 3
-    }
-    ];
-
-    const builds = builds1.concat(builds2);
-
-    const buildrequests = [{
-        builderid: 1,
-        buildrequestid: 1,
-        buildsetid: 1
-    }
-    , {
-        builderid: 1,
-        buildrequestid: 2,
-        buildsetid: 1
-    }
-    , {
-        builderid: 1,
-        buildrequestid: 3,
-        buildsetid: 2
-    }
-    ];
-
-    const buildsets = [{
-        bsid: 1,
-        sourcestamps: [
-            {ssid: 1}
-        ]
-    }
-    , {
-        bsid: 2,
-        sourcestamps: [
-            {ssid: 2}
-        ]
-    }
-    ];
-
-    const changes = [{
-        changeid: 1,
-        sourcestamp: {
-            ssid: 1
-        }
-    }
-    ];
-    let createController = (scope = ($rootScope = (dataService = ($window = ($timeout = null)))));
-
-    const injected = function($injector) {
-        const $q = $injector.get('$q');
-        $rootScope = $injector.get('$rootScope');
-        $window = $injector.get('$window');
-        $timeout = $injector.get('$timeout');
-        dataService = $injector.get('dataService');
-        scope = $rootScope.$new();
-        dataService.when('builds', builds);
-        dataService.when('builders', builders);
-        dataService.when('changes', changes);
-        dataService.when('buildrequests', buildrequests);
-        dataService.when('buildsets', buildsets);
-
-        // Create new controller using controller as syntax
-        const $controller = $injector.get('$controller');
-        createController = () =>
-            $controller('consoleController as c', {
-                // Inject controller dependencies
-                $q,
-                $window,
-                $scope: scope
-            }
-            )
-        ;
-    };
-
-    beforeEach(inject(injected));
-
-    it('should be defined', function() {
-        createController();
-        expect(scope.c).toBeDefined();
-    });
-
-    it('should bind the builds, builders, changes, buildrequests and buildsets to scope', function() {
-        createController();
-        $rootScope.$digest();
-        $timeout.flush();
-        expect(scope.c.builds).toBeDefined();
-        expect(scope.c.builds.length).toBe(builds.length);
-        expect(scope.c.all_builders).toBeDefined();
-        expect(scope.c.all_builders.length).toBe(builders.length);
-        expect(scope.c.changes).toBeDefined();
-        expect(scope.c.changes.length).toBe(changes.length);
-        expect(scope.c.buildrequests).toBeDefined();
-        expect(scope.c.buildrequests.length).toBe(buildrequests.length);
-        expect(scope.c.buildsets).toBeDefined();
-        expect(scope.c.buildsets.length).toBe(buildsets.length);
-    });
-
-    it('should match the builds with the change', function() {
-        createController();
-        $timeout.flush();
-        $rootScope.$digest();
-        $timeout.flush();
-        expect(scope.c.changes[0]).toBeDefined();
-        expect(scope.c.changes[0].builders).toBeDefined();
-        ({ builders } = scope.c.changes[0]);
-        expect(builders[0].builds[0].buildid).toBe(1);
-        expect(builders[1].builds[0].buildid).toBe(2);
-        expect(builders[2].builds[0].buildid).toBe(4);
-        expect(builders[3].builds[0].buildid).toBe(3);
-    });
-
-    xit('should match sort the builders by tag groups', function() {
-        createController();
-        const _builders = FIXTURES['builders.fixture.json'].builders;
-        for (let builder of Array.from(_builders)) {
-            builder.hasBuild = true;
-        }
-        scope.c.sortBuildersByTags(_builders);
-        expect(_builders.length).toBe(scope.c.builders.length);
-        expect(scope.c.tag_lines.length).toEqual(5);
-    });
-});
diff --git a/yocto_console_view/src/module/releaseselectorfield.directive.js b/yocto_console_view/src/module/releaseselectorfield.directive.js
deleted file mode 100644
index 9a14adb802d1..000000000000
--- a/yocto_console_view/src/module/releaseselectorfield.directive.js
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * decaffeinate suggestions:
- * DS002: Fix invalid constructor
- * DS101: Remove unnecessary use of Array.from
- * DS102: Remove unnecessary code created because of implicit returns
- * DS205: Consider reworking code to avoid use of IIFEs
- * DS207: Consider shorter variations of null checks
- * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
- */
-
-class Releaseselectorfield {
-    constructor() {
-        return {
-            replace: false,
-            restrict: 'E',
-            scope: false,
-            template: require('./releaseselectorfield.tpl.jade'),
-            controller: '_ReleaseselectorfieldController'
-        };
-    }
-}
-
-class _releaseselectorfield {
-    constructor($scope, $http) {
-        // HACK: we find the rootfield by doing $scope.$parent.$parent
-        let rootfield = $scope;
-        while ((rootfield != null) && (rootfield.rootfield == null)) {
-            rootfield = rootfield.$parent;
-        }
-
-        if ((rootfield == null)) {
-            console.log("rootfield not found!?!?");
-            return;
-        }
-
-        // copy paste of code in forcedialog, which flatten the fields to be able to find easily
-        const fields_ref = {};
-        var gatherFields = fields => Array.from(fields).map((field) =>
-            (field.fields != null) ?
-                gatherFields(field.fields)
-            :
-                (fields_ref[field.fullName] = field));
-
-        gatherFields(rootfield.rootfield.fields);
-
-        // when our field change, we update the fields that we are suppose to
-        $scope.$watch("field.value", function(n, o) {
-
-            const selector = $scope.field.selectors[n];
-            if (selector != null) {
-                return (() => {
-                    const result = [];
-                    for (let k in selector) {
-                        const v = selector[k];
-                        if (k in fields_ref) {
-                            result.push(fields_ref[k].value = v);
-                        }
-                    }
-                    return result;
-                })();
-            }
-        });
-    }
-}
-
-angular.module('yocto_console_view')
-.directive('releaseselectorfield', [Releaseselectorfield])
-.controller('_ReleaseselectorfieldController', ['$scope', '$http', _releaseselectorfield])
diff --git a/yocto_console_view/src/module/releaseselectorfield.tpl.jade b/yocto_console_view/src/module/releaseselectorfield.tpl.jade
deleted file mode 100644
index 8284d1d38b5f..000000000000
--- a/yocto_console_view/src/module/releaseselectorfield.tpl.jade
+++ /dev/null
@@ -1,5 +0,0 @@
-basefield
-    label.control-label.col-sm-2(for="{{field.name}}")
-        | {{field.label}}
-    .col-sm-10
-        select.form-control(ng-model="field.value", ng-options="v for v in field.choices")
diff --git a/yocto_console_view/src/module/view/modal/modal.controller.js b/yocto_console_view/src/module/view/modal/modal.controller.js
deleted file mode 100644
index b2cea0d97648..000000000000
--- a/yocto_console_view/src/module/view/modal/modal.controller.js
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * decaffeinate suggestions:
- * DS102: Remove unnecessary code created because of implicit returns
- * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
- */
-class ConsoleModal {
-    constructor($scope, $uibModalInstance, selectedBuild) {
-        this.$uibModalInstance = $uibModalInstance;
-        this.selectedBuild = selectedBuild;
-        $scope.$on('$stateChangeStart', () => {
-            return this.close();
-        });
-    }
-
-    close() {
-        return this.$uibModalInstance.close();
-    }
-}
-
-
-angular.module('yocto_console_view')
-.controller('consoleModalController', ['$scope', '$uibModalInstance', 'selectedBuild', ConsoleModal]);
diff --git a/yocto_console_view/src/module/view/modal/modal.style.less b/yocto_console_view/src/module/view/modal/modal.style.less
deleted file mode 100644
index a11aa3b1ec82..000000000000
--- a/yocto_console_view/src/module/view/modal/modal.style.less
+++ /dev/null
@@ -1,9 +0,0 @@
-.modal-big {
-  .modal-dialog {
-    width: 80%;
-  }
-
-  .fa {
-    cursor: pointer;
-  }
-}
diff --git a/yocto_console_view/src/module/view/modal/modal.tpl.jade b/yocto_console_view/src/module/view/modal/modal.tpl.jade
deleted file mode 100644
index 532d68ea3ffc..000000000000
--- a/yocto_console_view/src/module/view/modal/modal.tpl.jade
+++ /dev/null
@@ -1,6 +0,0 @@
-// Show build summary for the selected build in a modal window
-.modal-header
-    i.fa.fa-times.pull-right(ng-click='modal.close()')
-    h4.modal-title Build summary
-.modal-body
-    buildsummary(ng-if='modal.selectedBuild' buildid='modal.selectedBuild.buildid')
\ No newline at end of file
diff --git a/yocto_console_view/src/module/yoctochangedetails.directive.js b/yocto_console_view/src/module/yoctochangedetails.directive.js
deleted file mode 100644
index 8161ff453b95..000000000000
--- a/yocto_console_view/src/module/yoctochangedetails.directive.js
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * decaffeinate suggestions:
- * DS002: Fix invalid constructor
- * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
- */
-class Yoctochangedetails {
-    constructor() {
-        return {
-            replace: true,
-            restrict: 'E',
-            scope: {
-                change: '=',
-                compact: '=?'
-            },
-            template: require('./yoctochangedetails.tpl.jade')
-        };
-    }
-}
-
-angular.module('yocto_console_view')
-.directive('yoctochangedetails', [Yoctochangedetails])
diff --git a/yocto_console_view/src/module/yoctochangedetails.tpl.jade b/yocto_console_view/src/module/yoctochangedetails.tpl.jade
deleted file mode 100644
index 541589032369..000000000000
--- a/yocto_console_view/src/module/yoctochangedetails.tpl.jade
+++ /dev/null
@@ -1,42 +0,0 @@
-div.yoctochangedetails(style="width:100%;")
-    div(style="width:100%;", ng-click="change.show_details = !change.show_details")
-        a(ng-if="change.revlink", ng-href="{{change.revlink}}", uib-tooltip="{{change.comments}}")
-            | {{ change.caption }} &nbsp;
-        a(ng-if="change.errorlink", ng-href="{{change.errorlink}}")
-            | {{ "Errors" }} &nbsp;
-        a(ng-if="change.publishurl", ng-href="{{change.publishurl}}")
-            | {{ "Output" }} &nbsp;
-        span(ng-if="!change.revlink", uib-tooltip="{{change.comments}}")
-            | {{ change.caption }} &nbsp;
-        span(ng-if="!compact" uib-tooltip="{{change.when_timestamp | dateformat:'LLL'}}")
-            | ({{ change.when_timestamp | timeago }}) &nbsp;
-        i.fa.fa-chevron-circle-right.rotate.clickable(ng-class="{'fa-rotate-90':change.show_details}")
-    div.anim-changedetails(ng-show="change.show_details")
-        table.table.table-striped.table-condensed(ng-show="change.show_details")
-          tr(ng-show="change.reason")
-            td Reason
-            td {{ change.reason }}
-          tr(ng-show="change.author")
-            td Author
-            td {{ change.author }}
-          tr
-            td Date
-            td {{ change.when_timestamp | dateformat:'LLL'}} ({{ change.when_timestamp | timeago }})
-          tr(ng-show="change.repository")
-            td Repository
-            td {{ change.repository }}
-          tr(ng-show="change.branch")
-            td Branch
-            td {{ change.branch }}
-          tr
-            td Revision
-            td 
-              a(ng-if="change.revlink", ng-href="{{change.revlink}}") 
-                | {{ change.revision }}
-
-        h5 Comment
-        pre {{ change.comments }}
-        h5 Changed files
-        ul
-          li(ng-repeat='file in change.files') {{file}}
-        p(ng-hide="change.files.length") No files
diff --git a/yocto_console_view/src/styles/styles.less b/yocto_console_view/src/styles/styles.less
deleted file mode 100644
index 596760968a62..000000000000
--- a/yocto_console_view/src/styles/styles.less
+++ /dev/null
@@ -1,89 +0,0 @@
-@column-width: 40px;
-@headcol-width: 20px;
-
-.console {
-    .table-fixedwidth {
-        width: initial;
-    }
-    .load-indicator {
-        width: 100%;
-        height: 100%;
-        z-index: 900;
-        background-color: #ffffff;
-        display: table;
-
-        .spinner {
-            display: table-cell;
-            vertical-align: middle;
-            text-align: center;
-
-            p {
-                font-weight: 300;
-                margin-top: 10px;
-            }
-        }
-    }
-
-    .column {
-        min-width: @column-width;
-        max-width: @column-width;
-        width: @column-width;
-    }
-    table {
-        border: none;
-    }
-    .tag_row{
-        td {
-            margin:0px;
-            padding:0px;
-        }
-        span {
-            position: relative;
-            float: left;
-            font-size: 10px;
-            overflow: hidden;
-            text-decoration: none;
-            white-space: nowrap;
-        }
-    }
-    tr.first-row {
-        background-color: #fff!important;
-        th {
-        border: none;
-        background-color: #fff !important;
-        }
-        .builder {
-            position: relative;
-            float: left;
-            font-size: 12px;
-            text-align: center;
-            transform: rotate(-45deg) ;
-            transform-origin: 0% 100%;
-            text-decoration: none;
-            white-space: nowrap;
-        }
-        .column {
-            width: @headcol-width;
-            min-width: @headcol-width;
-            max-width: @headcol-width;
-        }
-    }
-
-}
-
-.yoctochangedetails > .no-select > * {
-    margin-left: 0.3em;
-    margin-right: 0.3em;
-}
-
-.select-editable {
-        position:absolute;
-        top:0;
-        border:none;
-        margin:2px;
-        width:90%;
-        height:29px;
-}
-.select-editable input:focus {
-        outline:none;
-}
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
new file mode 100644
index 000000000000..dabd8a48b608
--- /dev/null
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
@@ -0,0 +1,38 @@
+
+tr.bb-console-table-first-row {
+  background-color: #fff !important;
+  th {
+    border: none;
+  }
+}
+
+.bb-console-table-builder {
+  position: relative;
+  float: left;
+  font-size: 1em;
+  width: 1.5em;
+  text-align: center;
+  transform: rotate(-25deg) ;
+  transform-origin: 0% 100%;
+  text-decoration: none;
+  white-space: nowrap;
+}
+
+.bb-console-tag-row {
+  td {
+    margin: 0;
+    padding: 0;
+  }
+  span {
+    position: relative;
+    float: left;
+    font-size: 10px;
+    overflow: hidden;
+    text-decoration: none;
+    white-space: nowrap;
+  }
+}
+
+.bb-console-changes-expand-icon {
+  float: left;
+}
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.test.ts b/yocto_console_view/src/views/ConsoleView/ConsoleView.test.ts
new file mode 100644
index 000000000000..8f5411724a24
--- /dev/null
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.test.ts
@@ -0,0 +1,97 @@
+/*
+  This file is part of Buildbot.  Buildbot is free software: you can
+  redistribute it and/or modify it under the terms of the GNU General Public
+  License as published by the Free Software Foundation, version 2.
+
+  This program is distributed in the hope that it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+  details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 51
+  Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+  Copyright Buildbot Team Members
+*/
+
+import {describe, expect, it} from "vitest";
+import {Builder, IDataAccessor} from "buildbot-data-js";
+import {sortBuildersByTags, TagLineConfig} from "./ConsoleView";
+
+type TestBuilder = {
+  builderid: number;
+  tags: string[];
+}
+
+function testBuilderToReal(b: TestBuilder) {
+  return new Builder(undefined as unknown as IDataAccessor, 'a/1', {
+    builderid: b.builderid,
+    description: "desc",
+    masterids: [1],
+    name: `name${b.builderid}`,
+    tags: b.tags,
+  });
+}
+
+describe('ConsoleView', function() {
+  describe('sortBuildersByTags', function() {
+
+    function testSortBuildersByTags(builders: TestBuilder[],
+                                    expectedBuilders: TestBuilder[],
+                                    expectedTagLines: TagLineConfig[]) {
+      const [resultBuilders, resultLineConfigs] =
+        sortBuildersByTags(builders.map(b => testBuilderToReal(b)));
+
+      expect(resultBuilders).toStrictEqual(expectedBuilders.map(b => testBuilderToReal(b)));
+      expect(resultLineConfigs).toStrictEqual(expectedTagLines);
+    }
+
+    it('empty', function() {
+      testSortBuildersByTags([], [], []);
+    });
+
+    it('identical tag', function() {
+      testSortBuildersByTags([
+        {builderid: 1, tags: ['tag']},
+        {builderid: 2, tags: ['tag']},
+        {builderid: 3, tags: ['tag']}
+      ], [
+        {builderid: 1, tags: ['tag']},
+        {builderid: 2, tags: ['tag']},
+        {builderid: 3, tags: ['tag']}
+      ], []);
+    });
+
+    it('two tags', function() {
+      testSortBuildersByTags([
+        {builderid: 1, tags: ['tag']},
+        {builderid: 2, tags: ['tag']},
+        {builderid: 3, tags: ['tag']},
+        {builderid: 4, tags: ['tag2']}
+      ], [
+        {builderid: 1, tags: ['tag']},
+        {builderid: 2, tags: ['tag']},
+        {builderid: 3, tags: ['tag']},
+        {builderid: 4, tags: ['tag2']}
+      ], [[{tag: 'tag', colSpan: 3}, {tag: 'tag2', colSpan: 1}]]);
+    });
+
+    it('hierarchical', function() {
+      testSortBuildersByTags([
+        {builderid: 1, tags: ['tag10', 'tag21']},
+        {builderid: 2, tags: ['tag10', 'tag21']},
+        {builderid: 3, tags: ['tag10', 'tag22']},
+        {builderid: 4, tags: ['tag11', 'tag22']}
+      ], [
+        {builderid: 1, tags: ['tag10', 'tag21']},
+        {builderid: 2, tags: ['tag10', 'tag21']},
+        {builderid: 3, tags: ['tag10', 'tag22']},
+        {builderid: 4, tags: ['tag11', 'tag22']},
+      ], [
+        [{tag: 'tag10', colSpan: 3}, {tag: 'tag11', colSpan: 1}],
+        [{tag: 'tag21', colSpan: 2}, {tag: 'tag22', colSpan: 1}, {tag: "", colSpan: 1}],
+      ]);
+    });
+  });
+});
diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
new file mode 100644
index 000000000000..b747f6a41de3
--- /dev/null
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -0,0 +1,541 @@
+/*
+  This file is part of Buildbot.  Buildbot is free software: you can
+  redistribute it and/or modify it under the terms of the GNU General Public
+  License as published by the Free Software Foundation, version 2.
+
+  This program is distributed in the hope that it will be useful, but WITHOUT
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+  details.
+
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 51
+  Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+  Copyright Buildbot Team Members
+*/
+
+import './ConsoleView.scss'
+import {ObservableMap} from "mobx";
+import {observer, useLocalObservable} from "mobx-react";
+import {Link} from "react-router-dom";
+import {
+  FaExclamationCircle,
+  FaMinusCircle,
+  FaPlusCircle
+} from "react-icons/fa";
+import {OverlayTrigger, Table, Tooltip} from "react-bootstrap";
+import {buildbotGetSettings, buildbotSetupPlugin} from "buildbot-plugin-support";
+import {
+  Build,
+  Buildset,
+  Builder,
+  Buildrequest,
+  Change,
+  useDataAccessor, useDataApiQuery, IDataAccessor
+} from "buildbot-data-js";
+import {
+  BuildLinkWithSummaryTooltip,
+  ChangeDetails,
+  LoadingIndicator,
+  pushIntoMapOfArrays,
+  useWindowSize
+} from "buildbot-ui";
+
+type ChangeInfo = {
+  change: Change;
+  buildsByBuilderId: Map<number, Build[]>;
+}
+
+export type TagTreeItem = {
+  builders: Builder[];
+  tag: string;
+  childItems: TagTreeItem[];
+}
+
+export type TagItemConfig = {
+  tag: string,
+  colSpan: number
+};
+
+export type TagLineConfig = TagItemConfig[];
+
+export function buildTagTree(builders: Builder[])
+{
+  const buildersByTags = new Map<string, Builder[]>();
+  for (const builder of builders) {
+    if (builder.tags === null) {
+      continue;
+    }
+    for (const tag of builder.tags) {
+      pushIntoMapOfArrays(buildersByTags, tag, builder);
+    }
+  }
+
+  type TagInfo = {
+    tag: string;
+    builders: Builder[];
+  };
+
+  const undecidedTags: TagInfo[] = [];
+  for (const [tag, tagBuilders] of buildersByTags) {
+    if (tagBuilders.length < builders.length) {
+      undecidedTags.push({tag: tag, builders: tagBuilders});
+    }
+  }
+
+  // sort the tags to first look at tags with the larger number of builders
+  // @FIXME maybe this is not the best method to find the best groups
+  undecidedTags.sort((a, b) => b.builders.length - a.builders.length);
+
+  const tagItems: TagTreeItem[] = [];
+  const builderIdToTag = new Map<number, string>();
+
+  // pick the tags one by one, by making sure we make non-overalaping groups
+  for (const tagInfo of undecidedTags) {
+    let excluded = false;
+    for (const builder of tagInfo.builders) {
+      if (builderIdToTag.has(builder.builderid)) {
+        excluded = true;
+        break;
+      }
+    }
+    if (!excluded) {
+      for (const builder of tagInfo.builders) {
+        builderIdToTag.set(builder.builderid, tagInfo.tag);
+      }
+      tagItems.push({tag: tagInfo.tag, builders: tagInfo.builders, childItems: []});
+    }
+  }
+
+  // some builders do not have tags, we put them in another group
+  const remainingBuilders = [];
+  for (const builder of builders) {
+    if (!builderIdToTag.has(builder.builderid)) {
+      remainingBuilders.push(builder);
+    }
+  }
+
+  if (remainingBuilders.length) {
+    tagItems.push({tag: "", builders: remainingBuilders, childItems: []});
+  }
+
+  // if there is more than one tag in this line, we need to recurse
+  if (tagItems.length > 1) {
+    for (const tagItem of tagItems) {
+      tagItem.childItems = buildTagTree(tagItem.builders);
+    }
+  }
+  return tagItems;
+}
+
+// Sorts and groups builders together by their tags.
+export function sortBuildersByTags(builders: Builder[]) : [Builder[], TagLineConfig[]]
+{
+  // we call recursive function, which finds non-overlapping groups
+  const tagLineItems = buildTagTree(builders);
+
+  // we get a tree of builders grouped by tags
+  // we now need to flatten the tree, in order to build several lines of tags
+  // (each line is representing a depth in the tag tree)
+  // we walk the tree left to right and build the list of builders in the tree order, and the tag_lines
+  // in the tree, there are groups of remaining builders, which could not be grouped together,
+  // those have the empty tag ''
+  const tagLineConfigAtDepth = new Map<number, TagLineConfig>();
+
+  const resultBuilders: Builder[] = [];
+
+  const setTagLine = (depth: number, tag: string, colSpan: number) => {
+    const lineConfig = tagLineConfigAtDepth.get(depth);
+    if (lineConfig === undefined) {
+      tagLineConfigAtDepth.set(depth, [{tag: tag, colSpan: colSpan}]);
+      return;
+    }
+
+    // Attempt to merge identical tags
+    const lastItem = lineConfig[lineConfig.length - 1];
+    if (lastItem.tag === tag) {
+      lastItem.colSpan += colSpan;
+      return;
+    }
+    lineConfig.push({tag: tag, colSpan: colSpan});
+  };
+
+  const walkItemTree = (tagItem: TagTreeItem, depth: number) => {
+    setTagLine(depth, tagItem.tag, tagItem.builders.length);
+    if (tagItem.childItems.length === 0) {
+      // this is the leaf of the tree, sort by buildername, and add them to the
+      // list of sorted builders
+      tagItem.builders.sort((a, b) => a.name.localeCompare(b.name));
+
+      resultBuilders.push(...tagItem.builders);
+
+      for (let i = 1; i <= 100; i++) {
+        // set the remaining depth of the tree to the same colspan
+        // (we hardcode the maximum depth for now :/ )
+        setTagLine(depth + i, '', tagItem.builders.length);
+      }
+      return;
+    }
+    tagItem.childItems.map(item => walkItemTree(item, depth + 1));
+  };
+
+  for (const tagItem of tagLineItems) {
+    walkItemTree(tagItem, 0);
+  }
+
+  const resultTagLineConfigs: TagLineConfig[] = [];
+
+  for (const tagLineItems of tagLineConfigAtDepth.values()) {
+    if (tagLineItems.length === 1 && tagLineItems[0].tag === "") {
+      continue;
+    }
+    resultTagLineConfigs.push(tagLineItems);
+  }
+  return [resultBuilders, resultTagLineConfigs];
+}
+
+function resolveFakeChange(codebase: string, revision: string, whenTimestamp: number,
+                           changesByFakeId: Map<string, ChangeInfo>): ChangeInfo
+{
+  const fakeId = `${codebase}-${revision}`;
+  const existingChange = changesByFakeId.get(fakeId);
+  if (existingChange !== undefined) {
+    return existingChange;
+  }
+
+  const newChange = {
+    change: new Change(undefined as unknown as IDataAccessor, "a/1", {
+      changeid: 0,
+      author: "",
+      branch: "",
+      codebase: codebase,
+      comments: `Unknown revision ${revision}`,
+      files: [],
+      parent_changeids: [],
+      project: "",
+      properties: {},
+      repository: "",
+      revision: revision,
+      revlink: null,
+      when_timestamp: whenTimestamp,
+    }),
+    buildsByBuilderId: new Map<number, Build[]>
+  };
+  changesByFakeId.set(fakeId, newChange);
+  return newChange;
+}
+
+// Adjusts changesByFakeId for any new fake changes that are created
+function selectChangeForBuild(build: Build, buildset: Buildset,
+                              changesBySsid: Map<number, ChangeInfo>,
+                              changesByRevision: Map<string, ChangeInfo>,
+                              changesByFakeId: Map<string, ChangeInfo>) {
+  if (buildset.sourcestamps !== null) {
+    for (const sourcestamp of buildset.sourcestamps) {
+      const change = changesBySsid.get(sourcestamp.ssid);
+      if (change !== undefined) {
+        return change;
+      }
+    }
+  }
+
+  if (build.properties !== null && ('got_revision' in build.properties)) {
+    const revision = build.properties['got_revision'][0];
+    // got_revision can be per codebase or just the revision string
+    if (typeof(revision) === "string") {
+      const change = changesByRevision.get(revision);
+      if (change !== undefined) {
+        return change;
+      }
+
+      return resolveFakeChange("", revision, build.started_at, changesByFakeId);
+    }
+
+    const revisionMap = revision as {[codebase: string]: string};
+    for (const codebase in revisionMap) {
+      const codebaseRevision = revisionMap[codebase];
+      const change = changesByRevision.get(codebaseRevision);
+      if (change !== undefined) {
+        return change;
+      }
+    }
+
+    const codebases = Object.keys(revisionMap);
+    if (codebases.length === 0) {
+      return resolveFakeChange("unknown codebase", "", build.started_at, changesByFakeId);
+    }
+    return resolveFakeChange(codebases[0], revisionMap[codebases[0]], build.started_at,
+      changesByFakeId);
+  }
+
+  const revision = `unknown revision ${build.builderid}-${build.buildid}`;
+  return resolveFakeChange("unknown codebase", revision, build.started_at, changesByFakeId);
+}
+
+export const ConsoleView = observer(() => {
+  const accessor = useDataAccessor([]);
+
+  const settings = buildbotGetSettings();
+  const changeFetchLimit = settings.getIntegerSetting("Console.changeLimit");
+  const buildFetchLimit = settings.getIntegerSetting("Console.buildLimit");
+
+  const buildsetsQuery = useDataApiQuery(() => Buildset.getAll(accessor, {query: {
+      limit: buildFetchLimit,
+      order: '-submitted_at',
+    }}));
+
+  const changesQuery = useDataApiQuery(() => Change.getAll(accessor, {query: {
+      limit: changeFetchLimit,
+      order: '-changeid',
+    }}));
+
+  const buildersQuery = useDataApiQuery(() => Builder.getAll(accessor));
+
+  const buildrequestsQuery = useDataApiQuery(() => Buildrequest.getAll(accessor, {query: {
+      limit: buildFetchLimit,
+      order: '-submitted_at',
+    }}));
+
+  const buildsQuery = useDataApiQuery(() => Build.getAll(accessor, {query: {
+      limit: buildFetchLimit,
+      order: '-started_at',
+      property: ["got_revision"],
+    }}));
+
+  const windowSize = useWindowSize()
+  const changeIsExpandedByChangeId = useLocalObservable(() => new ObservableMap<number, boolean>());
+
+  const queriesResolved =
+    buildsetsQuery.resolved &&
+    changesQuery.resolved &&
+    buildersQuery.resolved &&
+    buildrequestsQuery.resolved &&
+    buildsQuery.resolved;
+
+  const builderIdsWithBuilds = new Set<number>();
+  for (const build of buildsQuery.array) {
+    builderIdsWithBuilds.add(build.builderid);
+  }
+
+  const buildersWithBuilds = buildersQuery.array.filter(b => builderIdsWithBuilds.has(b.builderid));
+  const [buildersToShow, tagLineConfigs] = sortBuildersByTags(buildersWithBuilds);
+
+  const changesByRevision = new Map<string, ChangeInfo>();
+  const changesBySsid = new Map<number, ChangeInfo>();
+  const changesByFakeId = new Map<string, ChangeInfo>();
+
+  for (const change of changesQuery.array) {
+    const changeInfo: ChangeInfo = {change: change, buildsByBuilderId: new Map<number, Build[]>()};
+    if (change.revision !== null) {
+      changesByRevision.set(change.revision, changeInfo);
+    }
+    changesBySsid.set(change.sourcestamp.ssid, changeInfo);
+  }
+
+  for (const build of buildsQuery.array) {
+    if (build.buildrequestid === null) {
+      continue;
+    }
+    const buildrequest = buildrequestsQuery.getByIdOrNull(build.buildrequestid.toString());
+    if (buildrequest === null) {
+      continue;
+    }
+    const buildset = buildsetsQuery.getByIdOrNull(buildrequest.buildsetid.toString());
+    if (buildset === null) {
+      continue;
+    }
+
+    const change = selectChangeForBuild(build, buildset, changesBySsid, changesByRevision,
+      changesByFakeId);
+
+    pushIntoMapOfArrays(change.buildsByBuilderId, build.builderid, build);
+  }
+
+  const changesToShow = [...changesBySsid.values(), ...changesByFakeId.values()]
+    .filter(ch => ch.buildsByBuilderId.size > 0)
+    .sort((a, b) => b.change.when_timestamp - a.change.when_timestamp);
+
+
+  const hasExpandedChanges = [...changeIsExpandedByChangeId.values()].includes(true);
+
+  // The magic value is selected so that the column holds 78 character lines without wrapping
+  const rowHeaderWidth = hasExpandedChanges ? 400 : 200;
+
+  // Determine if we use a 100% width table or if we allow horizontal scrollbar
+  // Depending on number of builders, and size of window, we need a fixed column size or a
+  // 100% width table
+  const isBigTable = () => {
+    const padding = rowHeaderWidth;
+    if (((windowSize.width - padding) / buildersToShow.length) < 40) {
+      return true;
+    }
+    return false;
+  }
+
+  const getColHeaderHeight = () => {
+    let maxBuilderName = 0;
+    for (const builder of buildersToShow) {
+      maxBuilderName = Math.max(builder.name.length, maxBuilderName);
+    }
+    return Math.max(100, maxBuilderName * 3);
+  }
+
+  const openAllChanges = () => {
+    for (const change of changesToShow) {
+      changeIsExpandedByChangeId.set(change.change.changeid, true);
+    }
+  };
+
+  const closeAllChanges = () => {
+    for (const changeid of changeIsExpandedByChangeId.keys()) {
+      changeIsExpandedByChangeId.set(changeid, false);
+    }
+  };
+
+  // FIXME: fa-spin
+  if (!queriesResolved) {
+    return (
+      <div className="bb-console-container">
+        <LoadingIndicator/>
+      </div>
+    );
+  }
+
+  if (changesQuery.array.length === 0) {
+    return (
+      <div className="bb-console-container">
+        <p>
+          No changes. Console View needs a changesource to be setup,
+          and <Link to="/changes">changes</Link> to be in the system.
+        </p>
+      </div>
+    );
+  }
+
+  const builderColumns = buildersToShow.map(builder => {
+    return (
+      <th key={builder.name} className="column">
+        <span style={{marginTop: getColHeaderHeight()}} className="bb-console-table-builder">
+          <Link to={`/builders/${builder.builderid}`}>{builder.name}</Link>
+        </span>
+      </th>
+    )
+  });
+
+  const tagLineRows = tagLineConfigs.map((tagLineConfig, i) => {
+    const columns = tagLineConfig.map((item, i) => {
+      return (
+        <td key={i} colSpan={item.colSpan}>
+          <span style={{width: item.colSpan * 50}}>{item.tag}</span>
+        </td>
+      );
+    });
+
+    return (
+      <tr className="bb-console-tag-row" key={`tag-${i}`}>
+        <td className="row-header"></td>
+        {columns}
+      </tr>
+    )
+  });
+
+  const changeRows = changesToShow.map(changeInfo => {
+    const change = changeInfo.change;
+
+    const builderColumns = buildersToShow.map(builder => {
+      const builds = changeInfo.buildsByBuilderId.get(builder.builderid) ?? [];
+      const buildLinks = builds.map(build => (
+        <BuildLinkWithSummaryTooltip key={build.buildid} build={build}/>
+      ));
+
+      return (
+        <td key={builder.name} title={builder.name} className="column">
+          {buildLinks}
+        </td>
+      );
+    });
+
+    // Note that changeid may not be unique because fake changes always have changeid of 0
+    return (
+      <tr key={`change-${change.changeid}-${change.codebase}-${change.revision ?? ''}`}>
+        <td>
+          <ChangeDetails change={change} compact={true}
+                         showDetails={changeIsExpandedByChangeId.get(change.changeid) ?? false}
+                         setShowDetails={(show: boolean) => changeIsExpandedByChangeId.set(change.changeid, show)}/>
+        </td>
+        {builderColumns}
+      </tr>
+    );
+  });
+
+  return (
+    <div className="container bb-console">
+      <Table striped bordered className={(isBigTable() ? 'table-fixedwidth' : '')}>
+        <thead>
+          <tr className="bb-console-table-first-row first-row">
+            <th className="row-header" style={{width: rowHeaderWidth}}>
+              <OverlayTrigger trigger="click" placement="top" overlay={
+                <Tooltip id="bb-console-view-open-all-changes">
+                  Open information for all changes
+                </Tooltip>
+              } rootClose={true}>
+                <FaPlusCircle onClick={e => openAllChanges()} className="bb-console-changes-expand-icon clickable"/>
+              </OverlayTrigger>
+
+              <OverlayTrigger trigger="click" placement="top" overlay={
+                <Tooltip id="bb-console-view-close-all-changes">
+                  Close information for all changes
+                </Tooltip>
+              } rootClose={true}>
+                <FaMinusCircle onClick={e => closeAllChanges()} className="bb-console-changes-expand-icon clickable"/>
+              </OverlayTrigger>
+            </th>
+            {builderColumns}
+          </tr>
+        </thead>
+        <tbody>
+          {tagLineRows}
+          {changeRows}
+        </tbody>
+      </Table>
+    </div>
+  );
+});
+
+buildbotSetupPlugin(reg => {
+  reg.registerMenuGroup({
+    name: 'console',
+    caption: 'Console View',
+    icon: <FaExclamationCircle/>,
+    order: 5,
+    route: '/console',
+    parentName: null,
+  });
+
+  reg.registerRoute({
+    route: "/console",
+    group: "console",
+    element: () => <ConsoleView/>,
+  });
+
+  reg.registerSettingGroup({
+    name: "Console",
+    caption: "Console related settings",
+    items: [
+      {
+        type: 'integer',
+        name: 'changeLimit',
+        caption: 'Maximum number of changes to fetch',
+        defaultValue: 30
+      }, {
+        type: 'integer',
+        name: 'buildLimit',
+        caption: 'Maximum number of builds to fetch',
+        defaultValue: 200
+      }
+    ]
+  });
+});
+
+export default ConsoleView;
diff --git a/yocto_console_view/test/main.coffee b/yocto_console_view/test/main.coffee
deleted file mode 100644
index 58acb546c7dd..000000000000
--- a/yocto_console_view/test/main.coffee
+++ /dev/null
@@ -1,2 +0,0 @@
-# app module is necessary for plugins, but only in the test environment
-angular.module("app", []).constant("config", {"url": "foourl"})
diff --git a/yocto_console_view/tsconfig.json b/yocto_console_view/tsconfig.json
new file mode 100644
index 000000000000..5416ca47bbf4
--- /dev/null
+++ b/yocto_console_view/tsconfig.json
@@ -0,0 +1,27 @@
+{
+  "compilerOptions": {
+    "experimentalDecorators": true,
+    "target": "es2020",
+    "lib": [
+      "dom",
+      "dom.iterable",
+      "esnext"
+    ],
+    "allowJs": true,
+    "skipLibCheck": true,
+    "esModuleInterop": true,
+    "allowSyntheticDefaultImports": true,
+    "strict": true,
+    "forceConsistentCasingInFileNames": true,
+    "noFallthroughCasesInSwitch": true,
+    "module": "esnext",
+    "moduleResolution": "node",
+    "resolveJsonModule": true,
+    "isolatedModules": true,
+    "noEmit": true,
+    "jsx": "react-jsx"
+  },
+  "include": [
+    "src"
+  ]
+}
diff --git a/yocto_console_view/vite.config.ts b/yocto_console_view/vite.config.ts
new file mode 100644
index 000000000000..168b120f19db
--- /dev/null
+++ b/yocto_console_view/vite.config.ts
@@ -0,0 +1,64 @@
+import {resolve} from "path";
+import {defineConfig} from "vite";
+import react from "@vitejs/plugin-react";
+
+const outDir = 'buildbot_console_view/static';
+
+export default defineConfig({
+  plugins: [
+    react({
+      babel: {
+        parserOpts: {
+          plugins: ['decorators-legacy', 'classProperties']
+        }
+      }
+    }),
+  ],
+  define: {
+    'process.env.NODE_ENV': '"production"',
+  },
+  build: {
+    lib: {
+      entry: resolve(__dirname, 'src/index.ts'),
+      name: "buildbotConsoleViewPlugin",
+      formats: ["umd"],
+      fileName: "scripts",
+    },
+    rollupOptions: {
+      external: [
+        'axios',
+        'buildbot-data-js',
+        'buildbot-plugin-support',
+        'buildbot-ui',
+        'mobx',
+        'mobx-react',
+        'moment',
+        'react',
+        'react-dom',
+        'react-router-dom'
+      ],
+      output: {
+        assetFileNames: 'styles.css',
+        entryFileNames: 'scripts.js',
+        globals: {
+          axios: "axios",
+          "buildbot-data-js": "BuildbotDataJs",
+          "buildbot-plugin-support": "BuildbotPluginSupport",
+          "buildbot-ui": "BuildbotUi",
+          mobx: "mobx",
+          "mobx-react": "mobxReact",
+          react: "React",
+          moment: "moment",
+          "react-dom": "ReactDOM",
+          "react-router-dom": "ReactRouterDOM",
+        },
+      },
+    },
+    target: ['es2020'],
+    outDir: outDir,
+    emptyOutDir: true,
+  },
+  test: {
+    environment: "jsdom"
+  },
+});
diff --git a/yocto_console_view/webpack.config.js b/yocto_console_view/webpack.config.js
deleted file mode 100644
index 74c7430a001f..000000000000
--- a/yocto_console_view/webpack.config.js
+++ /dev/null
@@ -1,26 +0,0 @@
-'use strict';
-
-const common = require('buildbot-build-common');
-const env = require('yargs').argv.env;
-const pkg = require('./package.json');
-
-var event = process.env.npm_lifecycle_event;
-
-var isTest = event === 'test' || event === 'test-watch';
-var isProd = env === 'prod';
-
-module.exports = function() {
-    return common.createTemplateWebpackConfig({
-        entry: {
-            scripts: './src/module/main.module.js',
-            styles: './src/styles/styles.less',
-        },
-        libraryName: pkg.name,
-        pluginName: pkg.plugin_name,
-        dirname: __dirname,
-        isTest: isTest,
-        isProd: isProd,
-        outputPath: __dirname + '/yocto_console_view/static',
-        extractStyles: true,
-    });
-}();
diff --git a/yocto_console_view/yarn.lock b/yocto_console_view/yarn.lock
new file mode 100644
index 000000000000..f6cd59ee969d
--- /dev/null
+++ b/yocto_console_view/yarn.lock
@@ -0,0 +1,1755 @@
+# THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.
+# yarn lockfile v1
+
+
+"@ampproject/remapping@^2.2.0", "@ampproject/remapping@^2.3.0":
+  version "2.3.0"
+  resolved "https://registry.yarnpkg.com/@ampproject/remapping/-/remapping-2.3.0.tgz#ed441b6fa600072520ce18b43d2c8cc8caecc7f4"
+  integrity sha512-30iZtAPgz+LTIYoeivqYo853f02jBYSd5uGnGpkFV0M3xOt9aN73erkgYAmZU43x4VfqcnLxW9Kpg3R5LC4YYw==
+  dependencies:
+    "@jridgewell/gen-mapping" "^0.3.5"
+    "@jridgewell/trace-mapping" "^0.3.24"
+
+"@babel/code-frame@^7.24.7":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/code-frame/-/code-frame-7.24.7.tgz#882fd9e09e8ee324e496bd040401c6f046ef4465"
+  integrity sha512-BcYH1CVJBO9tvyIZ2jVeXgSIMvGZ2FDRvDdOIVQyuklNKSsx+eppDEBq/g47Ayw+RqNFE+URvOShmf+f/qwAlA==
+  dependencies:
+    "@babel/highlight" "^7.24.7"
+    picocolors "^1.0.0"
+
+"@babel/compat-data@^7.25.2":
+  version "7.25.4"
+  resolved "https://registry.yarnpkg.com/@babel/compat-data/-/compat-data-7.25.4.tgz#7d2a80ce229890edcf4cc259d4d696cb4dae2fcb"
+  integrity sha512-+LGRog6RAsCJrrrg/IO6LGmpphNe5DiK30dGjCoxxeGv49B10/3XYGxPsAwrDlMFcFEvdAUavDT8r9k/hSyQqQ==
+
+"@babel/core@^7.24.5":
+  version "7.25.2"
+  resolved "https://registry.yarnpkg.com/@babel/core/-/core-7.25.2.tgz#ed8eec275118d7613e77a352894cd12ded8eba77"
+  integrity sha512-BBt3opiCOxUr9euZ5/ro/Xv8/V7yJ5bjYMqG/C1YAo8MIKAnumZalCN+msbci3Pigy4lIQfPUpfMM27HMGaYEA==
+  dependencies:
+    "@ampproject/remapping" "^2.2.0"
+    "@babel/code-frame" "^7.24.7"
+    "@babel/generator" "^7.25.0"
+    "@babel/helper-compilation-targets" "^7.25.2"
+    "@babel/helper-module-transforms" "^7.25.2"
+    "@babel/helpers" "^7.25.0"
+    "@babel/parser" "^7.25.0"
+    "@babel/template" "^7.25.0"
+    "@babel/traverse" "^7.25.2"
+    "@babel/types" "^7.25.2"
+    convert-source-map "^2.0.0"
+    debug "^4.1.0"
+    gensync "^1.0.0-beta.2"
+    json5 "^2.2.3"
+    semver "^6.3.1"
+
+"@babel/generator@^7.25.0", "@babel/generator@^7.25.6":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/generator/-/generator-7.25.6.tgz#0df1ad8cb32fe4d2b01d8bf437f153d19342a87c"
+  integrity sha512-VPC82gr1seXOpkjAAKoLhP50vx4vGNlF4msF64dSFq1P8RfB+QAuJWGHPXXPc8QyfVWwwB/TNNU4+ayZmHNbZw==
+  dependencies:
+    "@babel/types" "^7.25.6"
+    "@jridgewell/gen-mapping" "^0.3.5"
+    "@jridgewell/trace-mapping" "^0.3.25"
+    jsesc "^2.5.1"
+
+"@babel/helper-compilation-targets@^7.25.2":
+  version "7.25.2"
+  resolved "https://registry.yarnpkg.com/@babel/helper-compilation-targets/-/helper-compilation-targets-7.25.2.tgz#e1d9410a90974a3a5a66e84ff55ef62e3c02d06c"
+  integrity sha512-U2U5LsSaZ7TAt3cfaymQ8WHh0pxvdHoEk6HVpaexxixjyEquMh0L0YNJNM6CTGKMXV1iksi0iZkGw4AcFkPaaw==
+  dependencies:
+    "@babel/compat-data" "^7.25.2"
+    "@babel/helper-validator-option" "^7.24.8"
+    browserslist "^4.23.1"
+    lru-cache "^5.1.1"
+    semver "^6.3.1"
+
+"@babel/helper-module-imports@^7.24.7":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/helper-module-imports/-/helper-module-imports-7.24.7.tgz#f2f980392de5b84c3328fc71d38bd81bbb83042b"
+  integrity sha512-8AyH3C+74cgCVVXow/myrynrAGv+nTVg5vKu2nZph9x7RcRwzmh0VFallJuFTZ9mx6u4eSdXZfcOzSqTUm0HCA==
+  dependencies:
+    "@babel/traverse" "^7.24.7"
+    "@babel/types" "^7.24.7"
+
+"@babel/helper-module-transforms@^7.25.2":
+  version "7.25.2"
+  resolved "https://registry.yarnpkg.com/@babel/helper-module-transforms/-/helper-module-transforms-7.25.2.tgz#ee713c29768100f2776edf04d4eb23b8d27a66e6"
+  integrity sha512-BjyRAbix6j/wv83ftcVJmBt72QtHI56C7JXZoG2xATiLpmoC7dpd8WnkikExHDVPpi/3qCmO6WY1EaXOluiecQ==
+  dependencies:
+    "@babel/helper-module-imports" "^7.24.7"
+    "@babel/helper-simple-access" "^7.24.7"
+    "@babel/helper-validator-identifier" "^7.24.7"
+    "@babel/traverse" "^7.25.2"
+
+"@babel/helper-plugin-utils@^7.24.7":
+  version "7.24.8"
+  resolved "https://registry.yarnpkg.com/@babel/helper-plugin-utils/-/helper-plugin-utils-7.24.8.tgz#94ee67e8ec0e5d44ea7baeb51e571bd26af07878"
+  integrity sha512-FFWx5142D8h2Mgr/iPVGH5G7w6jDn4jUSpZTyDnQO0Yn7Ks2Kuz6Pci8H6MPCoUJegd/UZQ3tAvfLCxQSnWWwg==
+
+"@babel/helper-simple-access@^7.24.7":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/helper-simple-access/-/helper-simple-access-7.24.7.tgz#bcade8da3aec8ed16b9c4953b74e506b51b5edb3"
+  integrity sha512-zBAIvbCMh5Ts+b86r/CjU+4XGYIs+R1j951gxI3KmmxBMhCg4oQMsv6ZXQ64XOm/cvzfU1FmoCyt6+owc5QMYg==
+  dependencies:
+    "@babel/traverse" "^7.24.7"
+    "@babel/types" "^7.24.7"
+
+"@babel/helper-string-parser@^7.24.8":
+  version "7.24.8"
+  resolved "https://registry.yarnpkg.com/@babel/helper-string-parser/-/helper-string-parser-7.24.8.tgz#5b3329c9a58803d5df425e5785865881a81ca48d"
+  integrity sha512-pO9KhhRcuUyGnJWwyEgnRJTSIZHiT+vMD0kPeD+so0l7mxkMT19g3pjY9GTnHySck/hDzq+dtW/4VgnMkippsQ==
+
+"@babel/helper-validator-identifier@^7.24.7":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/helper-validator-identifier/-/helper-validator-identifier-7.24.7.tgz#75b889cfaf9e35c2aaf42cf0d72c8e91719251db"
+  integrity sha512-rR+PBcQ1SMQDDyF6X0wxtG8QyLCgUB0eRAGguqRLfkCA87l7yAP7ehq8SNj96OOGTO8OBV70KhuFYcIkHXOg0w==
+
+"@babel/helper-validator-option@^7.24.8":
+  version "7.24.8"
+  resolved "https://registry.yarnpkg.com/@babel/helper-validator-option/-/helper-validator-option-7.24.8.tgz#3725cdeea8b480e86d34df15304806a06975e33d"
+  integrity sha512-xb8t9tD1MHLungh/AIoWYN+gVHaB9kwlu8gffXGSt3FFEIT7RjS+xWbc2vUD1UTZdIpKj/ab3rdqJ7ufngyi2Q==
+
+"@babel/helpers@^7.25.0":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/helpers/-/helpers-7.25.6.tgz#57ee60141829ba2e102f30711ffe3afab357cc60"
+  integrity sha512-Xg0tn4HcfTijTwfDwYlvVCl43V6h4KyVVX2aEm4qdO/PC6L2YvzLHFdmxhoeSA3eslcE6+ZVXHgWwopXYLNq4Q==
+  dependencies:
+    "@babel/template" "^7.25.0"
+    "@babel/types" "^7.25.6"
+
+"@babel/highlight@^7.24.7":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/highlight/-/highlight-7.24.7.tgz#a05ab1df134b286558aae0ed41e6c5f731bf409d"
+  integrity sha512-EStJpq4OuY8xYfhGVXngigBJRWxftKX9ksiGDnmlY3o7B/V7KIAc9X4oiK87uPJSc/vs5L869bem5fhZa8caZw==
+  dependencies:
+    "@babel/helper-validator-identifier" "^7.24.7"
+    chalk "^2.4.2"
+    js-tokens "^4.0.0"
+    picocolors "^1.0.0"
+
+"@babel/parser@^7.1.0", "@babel/parser@^7.20.7", "@babel/parser@^7.25.0", "@babel/parser@^7.25.6":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/parser/-/parser-7.25.6.tgz#85660c5ef388cbbf6e3d2a694ee97a38f18afe2f"
+  integrity sha512-trGdfBdbD0l1ZPmcJ83eNxB9rbEax4ALFTF7fN386TMYbeCQbyme5cOEXQhbGXKebwGaB/J52w1mrklMcbgy6Q==
+  dependencies:
+    "@babel/types" "^7.25.6"
+
+"@babel/plugin-transform-react-jsx-self@^7.24.5":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/plugin-transform-react-jsx-self/-/plugin-transform-react-jsx-self-7.24.7.tgz#66bff0248ea0b549972e733516ffad577477bdab"
+  integrity sha512-fOPQYbGSgH0HUp4UJO4sMBFjY6DuWq+2i8rixyUMb3CdGixs/gccURvYOAhajBdKDoGajFr3mUq5rH3phtkGzw==
+  dependencies:
+    "@babel/helper-plugin-utils" "^7.24.7"
+
+"@babel/plugin-transform-react-jsx-source@^7.24.1":
+  version "7.24.7"
+  resolved "https://registry.yarnpkg.com/@babel/plugin-transform-react-jsx-source/-/plugin-transform-react-jsx-source-7.24.7.tgz#1198aab2548ad19582013815c938d3ebd8291ee3"
+  integrity sha512-J2z+MWzZHVOemyLweMqngXrgGC42jQ//R0KdxqkIz/OrbVIIlhFI3WigZ5fO+nwFvBlncr4MGapd8vTyc7RPNQ==
+  dependencies:
+    "@babel/helper-plugin-utils" "^7.24.7"
+
+"@babel/runtime@^7.13.8", "@babel/runtime@^7.14.0", "@babel/runtime@^7.5.5", "@babel/runtime@^7.6.3", "@babel/runtime@^7.8.7":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/runtime/-/runtime-7.25.6.tgz#9afc3289f7184d8d7f98b099884c26317b9264d2"
+  integrity sha512-VBj9MYyDb9tuLq7yzqjgzt6Q+IBQLrGZfdjOekyEirZPHxXWoTSGUTMrpsfi58Up73d13NfYLv8HT9vmznjzhQ==
+  dependencies:
+    regenerator-runtime "^0.14.0"
+
+"@babel/template@^7.25.0":
+  version "7.25.0"
+  resolved "https://registry.yarnpkg.com/@babel/template/-/template-7.25.0.tgz#e733dc3134b4fede528c15bc95e89cb98c52592a"
+  integrity sha512-aOOgh1/5XzKvg1jvVz7AVrx2piJ2XBi227DHmbY6y+bM9H2FlN+IfecYu4Xl0cNiiVejlsCri89LUsbj8vJD9Q==
+  dependencies:
+    "@babel/code-frame" "^7.24.7"
+    "@babel/parser" "^7.25.0"
+    "@babel/types" "^7.25.0"
+
+"@babel/traverse@^7.24.7", "@babel/traverse@^7.25.2":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/traverse/-/traverse-7.25.6.tgz#04fad980e444f182ecf1520504941940a90fea41"
+  integrity sha512-9Vrcx5ZW6UwK5tvqsj0nGpp/XzqthkT0dqIc9g1AdtygFToNtTF67XzYS//dm+SAK9cp3B9R4ZO/46p63SCjlQ==
+  dependencies:
+    "@babel/code-frame" "^7.24.7"
+    "@babel/generator" "^7.25.6"
+    "@babel/parser" "^7.25.6"
+    "@babel/template" "^7.25.0"
+    "@babel/types" "^7.25.6"
+    debug "^4.3.1"
+    globals "^11.1.0"
+
+"@babel/types@^7.0.0", "@babel/types@^7.20.7", "@babel/types@^7.24.7", "@babel/types@^7.25.0", "@babel/types@^7.25.2", "@babel/types@^7.25.6":
+  version "7.25.6"
+  resolved "https://registry.yarnpkg.com/@babel/types/-/types-7.25.6.tgz#893942ddb858f32ae7a004ec9d3a76b3463ef8e6"
+  integrity sha512-/l42B1qxpG6RdfYf343Uw1vmDjeNhneUXtzhojE7pDgfpEypmRhI6j1kr17XCVv4Cgl9HdAiQY2x0GwKm7rWCw==
+  dependencies:
+    "@babel/helper-string-parser" "^7.24.8"
+    "@babel/helper-validator-identifier" "^7.24.7"
+    to-fast-properties "^2.0.0"
+
+"@esbuild/aix-ppc64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/aix-ppc64/-/aix-ppc64-0.21.5.tgz#c7184a326533fcdf1b8ee0733e21c713b975575f"
+  integrity sha512-1SDgH6ZSPTlggy1yI6+Dbkiz8xzpHJEVAlF/AM1tHPLsf5STom9rwtjE4hKAF20FfXXNTFqEYXyJNWh1GiZedQ==
+
+"@esbuild/android-arm64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/android-arm64/-/android-arm64-0.21.5.tgz#09d9b4357780da9ea3a7dfb833a1f1ff439b4052"
+  integrity sha512-c0uX9VAUBQ7dTDCjq+wdyGLowMdtR/GoC2U5IYk/7D1H1JYC0qseD7+11iMP2mRLN9RcCMRcjC4YMclCzGwS/A==
+
+"@esbuild/android-arm@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/android-arm/-/android-arm-0.21.5.tgz#9b04384fb771926dfa6d7ad04324ecb2ab9b2e28"
+  integrity sha512-vCPvzSjpPHEi1siZdlvAlsPxXl7WbOVUBBAowWug4rJHb68Ox8KualB+1ocNvT5fjv6wpkX6o/iEpbDrf68zcg==
+
+"@esbuild/android-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/android-x64/-/android-x64-0.21.5.tgz#29918ec2db754cedcb6c1b04de8cd6547af6461e"
+  integrity sha512-D7aPRUUNHRBwHxzxRvp856rjUHRFW1SdQATKXH2hqA0kAZb1hKmi02OpYRacl0TxIGz/ZmXWlbZgjwWYaCakTA==
+
+"@esbuild/darwin-arm64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/darwin-arm64/-/darwin-arm64-0.21.5.tgz#e495b539660e51690f3928af50a76fb0a6ccff2a"
+  integrity sha512-DwqXqZyuk5AiWWf3UfLiRDJ5EDd49zg6O9wclZ7kUMv2WRFr4HKjXp/5t8JZ11QbQfUS6/cRCKGwYhtNAY88kQ==
+
+"@esbuild/darwin-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/darwin-x64/-/darwin-x64-0.21.5.tgz#c13838fa57372839abdddc91d71542ceea2e1e22"
+  integrity sha512-se/JjF8NlmKVG4kNIuyWMV/22ZaerB+qaSi5MdrXtd6R08kvs2qCN4C09miupktDitvh8jRFflwGFBQcxZRjbw==
+
+"@esbuild/freebsd-arm64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/freebsd-arm64/-/freebsd-arm64-0.21.5.tgz#646b989aa20bf89fd071dd5dbfad69a3542e550e"
+  integrity sha512-5JcRxxRDUJLX8JXp/wcBCy3pENnCgBR9bN6JsY4OmhfUtIHe3ZW0mawA7+RDAcMLrMIZaf03NlQiX9DGyB8h4g==
+
+"@esbuild/freebsd-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/freebsd-x64/-/freebsd-x64-0.21.5.tgz#aa615cfc80af954d3458906e38ca22c18cf5c261"
+  integrity sha512-J95kNBj1zkbMXtHVH29bBriQygMXqoVQOQYA+ISs0/2l3T9/kj42ow2mpqerRBxDJnmkUDCaQT/dfNXWX/ZZCQ==
+
+"@esbuild/linux-arm64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-arm64/-/linux-arm64-0.21.5.tgz#70ac6fa14f5cb7e1f7f887bcffb680ad09922b5b"
+  integrity sha512-ibKvmyYzKsBeX8d8I7MH/TMfWDXBF3db4qM6sy+7re0YXya+K1cem3on9XgdT2EQGMu4hQyZhan7TeQ8XkGp4Q==
+
+"@esbuild/linux-arm@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-arm/-/linux-arm-0.21.5.tgz#fc6fd11a8aca56c1f6f3894f2bea0479f8f626b9"
+  integrity sha512-bPb5AHZtbeNGjCKVZ9UGqGwo8EUu4cLq68E95A53KlxAPRmUyYv2D6F0uUI65XisGOL1hBP5mTronbgo+0bFcA==
+
+"@esbuild/linux-ia32@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-ia32/-/linux-ia32-0.21.5.tgz#3271f53b3f93e3d093d518d1649d6d68d346ede2"
+  integrity sha512-YvjXDqLRqPDl2dvRODYmmhz4rPeVKYvppfGYKSNGdyZkA01046pLWyRKKI3ax8fbJoK5QbxblURkwK/MWY18Tg==
+
+"@esbuild/linux-loong64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-loong64/-/linux-loong64-0.21.5.tgz#ed62e04238c57026aea831c5a130b73c0f9f26df"
+  integrity sha512-uHf1BmMG8qEvzdrzAqg2SIG/02+4/DHB6a9Kbya0XDvwDEKCoC8ZRWI5JJvNdUjtciBGFQ5PuBlpEOXQj+JQSg==
+
+"@esbuild/linux-mips64el@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-mips64el/-/linux-mips64el-0.21.5.tgz#e79b8eb48bf3b106fadec1ac8240fb97b4e64cbe"
+  integrity sha512-IajOmO+KJK23bj52dFSNCMsz1QP1DqM6cwLUv3W1QwyxkyIWecfafnI555fvSGqEKwjMXVLokcV5ygHW5b3Jbg==
+
+"@esbuild/linux-ppc64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-ppc64/-/linux-ppc64-0.21.5.tgz#5f2203860a143b9919d383ef7573521fb154c3e4"
+  integrity sha512-1hHV/Z4OEfMwpLO8rp7CvlhBDnjsC3CttJXIhBi+5Aj5r+MBvy4egg7wCbe//hSsT+RvDAG7s81tAvpL2XAE4w==
+
+"@esbuild/linux-riscv64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-riscv64/-/linux-riscv64-0.21.5.tgz#07bcafd99322d5af62f618cb9e6a9b7f4bb825dc"
+  integrity sha512-2HdXDMd9GMgTGrPWnJzP2ALSokE/0O5HhTUvWIbD3YdjME8JwvSCnNGBnTThKGEB91OZhzrJ4qIIxk/SBmyDDA==
+
+"@esbuild/linux-s390x@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-s390x/-/linux-s390x-0.21.5.tgz#b7ccf686751d6a3e44b8627ababc8be3ef62d8de"
+  integrity sha512-zus5sxzqBJD3eXxwvjN1yQkRepANgxE9lgOW2qLnmr8ikMTphkjgXu1HR01K4FJg8h1kEEDAqDcZQtbrRnB41A==
+
+"@esbuild/linux-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/linux-x64/-/linux-x64-0.21.5.tgz#6d8f0c768e070e64309af8004bb94e68ab2bb3b0"
+  integrity sha512-1rYdTpyv03iycF1+BhzrzQJCdOuAOtaqHTWJZCWvijKD2N5Xu0TtVC8/+1faWqcP9iBCWOmjmhoH94dH82BxPQ==
+
+"@esbuild/netbsd-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/netbsd-x64/-/netbsd-x64-0.21.5.tgz#bbe430f60d378ecb88decb219c602667387a6047"
+  integrity sha512-Woi2MXzXjMULccIwMnLciyZH4nCIMpWQAs049KEeMvOcNADVxo0UBIQPfSmxB3CWKedngg7sWZdLvLczpe0tLg==
+
+"@esbuild/openbsd-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/openbsd-x64/-/openbsd-x64-0.21.5.tgz#99d1cf2937279560d2104821f5ccce220cb2af70"
+  integrity sha512-HLNNw99xsvx12lFBUwoT8EVCsSvRNDVxNpjZ7bPn947b8gJPzeHWyNVhFsaerc0n3TsbOINvRP2byTZ5LKezow==
+
+"@esbuild/sunos-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/sunos-x64/-/sunos-x64-0.21.5.tgz#08741512c10d529566baba837b4fe052c8f3487b"
+  integrity sha512-6+gjmFpfy0BHU5Tpptkuh8+uw3mnrvgs+dSPQXQOv3ekbordwnzTVEb4qnIvQcYXq6gzkyTnoZ9dZG+D4garKg==
+
+"@esbuild/win32-arm64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/win32-arm64/-/win32-arm64-0.21.5.tgz#675b7385398411240735016144ab2e99a60fc75d"
+  integrity sha512-Z0gOTd75VvXqyq7nsl93zwahcTROgqvuAcYDUr+vOv8uHhNSKROyU961kgtCD1e95IqPKSQKH7tBTslnS3tA8A==
+
+"@esbuild/win32-ia32@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/win32-ia32/-/win32-ia32-0.21.5.tgz#1bfc3ce98aa6ca9a0969e4d2af72144c59c1193b"
+  integrity sha512-SWXFF1CL2RVNMaVs+BBClwtfZSvDgtL//G/smwAc5oVK/UPu2Gu9tIaRgFmYFFKrmg3SyAjSrElf0TiJ1v8fYA==
+
+"@esbuild/win32-x64@0.21.5":
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/@esbuild/win32-x64/-/win32-x64-0.21.5.tgz#acad351d582d157bb145535db2a6ff53dd514b5c"
+  integrity sha512-tQd/1efJuzPC6rCFwEvLtci/xNFcTZknmXs98FYDfGE4wP9ClFV98nyKrzJKVPMhdDnjzLhdUyMX4PsQAPjwIw==
+
+"@jridgewell/gen-mapping@^0.3.5":
+  version "0.3.5"
+  resolved "https://registry.yarnpkg.com/@jridgewell/gen-mapping/-/gen-mapping-0.3.5.tgz#dcce6aff74bdf6dad1a95802b69b04a2fcb1fb36"
+  integrity sha512-IzL8ZoEDIBRWEzlCcRhOaCupYyN5gdIK+Q6fbFdPDg6HqX6jpkItn7DFIpW9LQzXG6Df9sA7+OKnq0qlz/GaQg==
+  dependencies:
+    "@jridgewell/set-array" "^1.2.1"
+    "@jridgewell/sourcemap-codec" "^1.4.10"
+    "@jridgewell/trace-mapping" "^0.3.24"
+
+"@jridgewell/resolve-uri@^3.1.0":
+  version "3.1.2"
+  resolved "https://registry.yarnpkg.com/@jridgewell/resolve-uri/-/resolve-uri-3.1.2.tgz#7a0ee601f60f99a20c7c7c5ff0c80388c1189bd6"
+  integrity sha512-bRISgCIjP20/tbWSPWMEi54QVPRZExkuD9lJL+UIxUKtwVJA8wW1Trb1jMs1RFXo1CBTNZ/5hpC9QvmKWdopKw==
+
+"@jridgewell/set-array@^1.2.1":
+  version "1.2.1"
+  resolved "https://registry.yarnpkg.com/@jridgewell/set-array/-/set-array-1.2.1.tgz#558fb6472ed16a4c850b889530e6b36438c49280"
+  integrity sha512-R8gLRTZeyp03ymzP/6Lil/28tGeGEzhx1q2k703KGWRAI1VdvPIXdG70VJc2pAMw3NA6JKL5hhFu1sJX0Mnn/A==
+
+"@jridgewell/sourcemap-codec@^1.4.10", "@jridgewell/sourcemap-codec@^1.4.14", "@jridgewell/sourcemap-codec@^1.5.0":
+  version "1.5.0"
+  resolved "https://registry.yarnpkg.com/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.5.0.tgz#3188bcb273a414b0d215fd22a58540b989b9409a"
+  integrity sha512-gv3ZRaISU3fjPAgNsriBRqGWQL6quFx04YMPW/zD8XMLsU32mhCCbfbO6KZFLjvYpCZ8zyDEgqsgf+PwPaM7GQ==
+
+"@jridgewell/trace-mapping@^0.3.24", "@jridgewell/trace-mapping@^0.3.25":
+  version "0.3.25"
+  resolved "https://registry.yarnpkg.com/@jridgewell/trace-mapping/-/trace-mapping-0.3.25.tgz#15f190e98895f3fc23276ee14bc76b675c2e50f0"
+  integrity sha512-vNk6aEwybGtawWmy/PzwnGDOjCkLWSD2wqvjGGAgOAwCGWySYXfYoxt00IJkTF+8Lb57DwOb3Aa0o9CApepiYQ==
+  dependencies:
+    "@jridgewell/resolve-uri" "^3.1.0"
+    "@jridgewell/sourcemap-codec" "^1.4.14"
+
+"@popperjs/core@^2.11.6":
+  version "2.11.8"
+  resolved "https://registry.yarnpkg.com/@popperjs/core/-/core-2.11.8.tgz#6b79032e760a0899cd4204710beede972a3a185f"
+  integrity sha512-P1st0aksCrn9sGZhp8GMYwBnQsbvAWsZAX44oXNNvLHGqAOcoVxmjZiohstwQ7SqKnbR47akdNi+uleWD8+g6A==
+
+"@remix-run/router@1.19.1":
+  version "1.19.1"
+  resolved "https://registry.yarnpkg.com/@remix-run/router/-/router-1.19.1.tgz#984771bfd1de2715f42394c87fb716c1349e014f"
+  integrity sha512-S45oynt/WH19bHbIXjtli6QmwNYvaz+vtnubvNpNDvUOoA/OWh6j1OikIP3G+v5GHdxyC6EXoChG3HgYGEUfcg==
+
+"@restart/context@^2.1.4":
+  version "2.1.4"
+  resolved "https://registry.yarnpkg.com/@restart/context/-/context-2.1.4.tgz#a99d87c299a34c28bd85bb489cb07bfd23149c02"
+  integrity sha512-INJYZQJP7g+IoDUh/475NlGiTeMfwTXUEr3tmRneckHIxNolGOW9CTq83S8cxq0CgJwwcMzMJFchxvlwe7Rk8Q==
+
+"@restart/hooks@^0.4.7":
+  version "0.4.16"
+  resolved "https://registry.yarnpkg.com/@restart/hooks/-/hooks-0.4.16.tgz#95ae8ac1cc7e2bd4fed5e39800ff85604c6d59fb"
+  integrity sha512-f7aCv7c+nU/3mF7NWLtVVr0Ra80RqsO89hO72r+Y/nvQr5+q0UFGkocElTH6MJApvReVh6JHUFYn2cw1WdHF3w==
+  dependencies:
+    dequal "^2.0.3"
+
+"@rollup/rollup-android-arm-eabi@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-android-arm-eabi/-/rollup-android-arm-eabi-4.22.4.tgz#8b613b9725e8f9479d142970b106b6ae878610d5"
+  integrity sha512-Fxamp4aEZnfPOcGA8KSNEohV8hX7zVHOemC8jVBoBUHu5zpJK/Eu3uJwt6BMgy9fkvzxDaurgj96F/NiLukF2w==
+
+"@rollup/rollup-android-arm64@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-android-arm64/-/rollup-android-arm64-4.22.4.tgz#654ca1049189132ff602bfcf8df14c18da1f15fb"
+  integrity sha512-VXoK5UMrgECLYaMuGuVTOx5kcuap1Jm8g/M83RnCHBKOqvPPmROFJGQaZhGccnsFtfXQ3XYa4/jMCJvZnbJBdA==
+
+"@rollup/rollup-darwin-arm64@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-darwin-arm64/-/rollup-darwin-arm64-4.22.4.tgz#6d241d099d1518ef0c2205d96b3fa52e0fe1954b"
+  integrity sha512-xMM9ORBqu81jyMKCDP+SZDhnX2QEVQzTcC6G18KlTQEzWK8r/oNZtKuZaCcHhnsa6fEeOBionoyl5JsAbE/36Q==
+
+"@rollup/rollup-darwin-x64@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-darwin-x64/-/rollup-darwin-x64-4.22.4.tgz#42bd19d292a57ee11734c980c4650de26b457791"
+  integrity sha512-aJJyYKQwbHuhTUrjWjxEvGnNNBCnmpHDvrb8JFDbeSH3m2XdHcxDd3jthAzvmoI8w/kSjd2y0udT+4okADsZIw==
+
+"@rollup/rollup-linux-arm-gnueabihf@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-arm-gnueabihf/-/rollup-linux-arm-gnueabihf-4.22.4.tgz#f23555ee3d8fe941c5c5fd458cd22b65eb1c2232"
+  integrity sha512-j63YtCIRAzbO+gC2L9dWXRh5BFetsv0j0va0Wi9epXDgU/XUi5dJKo4USTttVyK7fGw2nPWK0PbAvyliz50SCQ==
+
+"@rollup/rollup-linux-arm-musleabihf@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-arm-musleabihf/-/rollup-linux-arm-musleabihf-4.22.4.tgz#f3bbd1ae2420f5539d40ac1fde2b38da67779baa"
+  integrity sha512-dJnWUgwWBX1YBRsuKKMOlXCzh2Wu1mlHzv20TpqEsfdZLb3WoJW2kIEsGwLkroYf24IrPAvOT/ZQ2OYMV6vlrg==
+
+"@rollup/rollup-linux-arm64-gnu@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-arm64-gnu/-/rollup-linux-arm64-gnu-4.22.4.tgz#7abe900120113e08a1f90afb84c7c28774054d15"
+  integrity sha512-AdPRoNi3NKVLolCN/Sp4F4N1d98c4SBnHMKoLuiG6RXgoZ4sllseuGioszumnPGmPM2O7qaAX/IJdeDU8f26Aw==
+
+"@rollup/rollup-linux-arm64-musl@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-arm64-musl/-/rollup-linux-arm64-musl-4.22.4.tgz#9e655285c8175cd44f57d6a1e8e5dedfbba1d820"
+  integrity sha512-Gl0AxBtDg8uoAn5CCqQDMqAx22Wx22pjDOjBdmG0VIWX3qUBHzYmOKh8KXHL4UpogfJ14G4wk16EQogF+v8hmA==
+
+"@rollup/rollup-linux-powerpc64le-gnu@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-powerpc64le-gnu/-/rollup-linux-powerpc64le-gnu-4.22.4.tgz#9a79ae6c9e9d8fe83d49e2712ecf4302db5bef5e"
+  integrity sha512-3aVCK9xfWW1oGQpTsYJJPF6bfpWfhbRnhdlyhak2ZiyFLDaayz0EP5j9V1RVLAAxlmWKTDfS9wyRyY3hvhPoOg==
+
+"@rollup/rollup-linux-riscv64-gnu@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-riscv64-gnu/-/rollup-linux-riscv64-gnu-4.22.4.tgz#67ac70eca4ace8e2942fabca95164e8874ab8128"
+  integrity sha512-ePYIir6VYnhgv2C5Xe9u+ico4t8sZWXschR6fMgoPUK31yQu7hTEJb7bCqivHECwIClJfKgE7zYsh1qTP3WHUA==
+
+"@rollup/rollup-linux-s390x-gnu@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-s390x-gnu/-/rollup-linux-s390x-gnu-4.22.4.tgz#9f883a7440f51a22ed7f99e1d070bd84ea5005fc"
+  integrity sha512-GqFJ9wLlbB9daxhVlrTe61vJtEY99/xB3C8e4ULVsVfflcpmR6c8UZXjtkMA6FhNONhj2eA5Tk9uAVw5orEs4Q==
+
+"@rollup/rollup-linux-x64-gnu@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-x64-gnu/-/rollup-linux-x64-gnu-4.22.4.tgz#70116ae6c577fe367f58559e2cffb5641a1dd9d0"
+  integrity sha512-87v0ol2sH9GE3cLQLNEy0K/R0pz1nvg76o8M5nhMR0+Q+BBGLnb35P0fVz4CQxHYXaAOhE8HhlkaZfsdUOlHwg==
+
+"@rollup/rollup-linux-x64-musl@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-linux-x64-musl/-/rollup-linux-x64-musl-4.22.4.tgz#f473f88219feb07b0b98b53a7923be716d1d182f"
+  integrity sha512-UV6FZMUgePDZrFjrNGIWzDo/vABebuXBhJEqrHxrGiU6HikPy0Z3LfdtciIttEUQfuDdCn8fqh7wiFJjCNwO+g==
+
+"@rollup/rollup-win32-arm64-msvc@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-win32-arm64-msvc/-/rollup-win32-arm64-msvc-4.22.4.tgz#4349482d17f5d1c58604d1c8900540d676f420e0"
+  integrity sha512-BjI+NVVEGAXjGWYHz/vv0pBqfGoUH0IGZ0cICTn7kB9PyjrATSkX+8WkguNjWoj2qSr1im/+tTGRaY+4/PdcQw==
+
+"@rollup/rollup-win32-ia32-msvc@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-win32-ia32-msvc/-/rollup-win32-ia32-msvc-4.22.4.tgz#a6fc39a15db618040ec3c2a24c1e26cb5f4d7422"
+  integrity sha512-SiWG/1TuUdPvYmzmYnmd3IEifzR61Tragkbx9D3+R8mzQqDBz8v+BvZNDlkiTtI9T15KYZhP0ehn3Dld4n9J5g==
+
+"@rollup/rollup-win32-x64-msvc@4.22.4":
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/@rollup/rollup-win32-x64-msvc/-/rollup-win32-x64-msvc-4.22.4.tgz#3dd5d53e900df2a40841882c02e56f866c04d202"
+  integrity sha512-j8pPKp53/lq9lMXN57S8cFz0MynJk8OWNuUnXct/9KCpKU7DgU3bYMJhwWmcqC0UU29p8Lr0/7KEVcaM6bf47Q==
+
+"@types/babel__core@^7.20.5":
+  version "7.20.5"
+  resolved "https://registry.yarnpkg.com/@types/babel__core/-/babel__core-7.20.5.tgz#3df15f27ba85319caa07ba08d0721889bb39c017"
+  integrity sha512-qoQprZvz5wQFJwMDqeseRXWv3rqMvhgpbXFfVyWhbx9X47POIA6i/+dXefEmZKoAgOaTdaIgNSMqMIU61yRyzA==
+  dependencies:
+    "@babel/parser" "^7.20.7"
+    "@babel/types" "^7.20.7"
+    "@types/babel__generator" "*"
+    "@types/babel__template" "*"
+    "@types/babel__traverse" "*"
+
+"@types/babel__generator@*":
+  version "7.6.8"
+  resolved "https://registry.yarnpkg.com/@types/babel__generator/-/babel__generator-7.6.8.tgz#f836c61f48b1346e7d2b0d93c6dacc5b9535d3ab"
+  integrity sha512-ASsj+tpEDsEiFr1arWrlN6V3mdfjRMZt6LtK/Vp/kreFLnr5QH5+DhvD5nINYZXzwJvXeGq+05iUXcAzVrqWtw==
+  dependencies:
+    "@babel/types" "^7.0.0"
+
+"@types/babel__template@*":
+  version "7.4.4"
+  resolved "https://registry.yarnpkg.com/@types/babel__template/-/babel__template-7.4.4.tgz#5672513701c1b2199bc6dad636a9d7491586766f"
+  integrity sha512-h/NUaSyG5EyxBIp8YRxo4RMe2/qQgvyowRwVMzhYhBCONbW8PUsg4lkFMrhgZhUe5z3L3MiLDuvyJ/CaPa2A8A==
+  dependencies:
+    "@babel/parser" "^7.1.0"
+    "@babel/types" "^7.0.0"
+
+"@types/babel__traverse@*":
+  version "7.20.6"
+  resolved "https://registry.yarnpkg.com/@types/babel__traverse/-/babel__traverse-7.20.6.tgz#8dc9f0ae0f202c08d8d4dab648912c8d6038e3f7"
+  integrity sha512-r1bzfrm0tomOI8g1SzvCaQHo6Lcv6zu0EA+W2kHrt8dyrHQxGzBBL4kdkzIS+jBMV+EYcMAEAqXqYaLJq5rOZg==
+  dependencies:
+    "@babel/types" "^7.20.7"
+
+"@types/estree@1.0.5", "@types/estree@^1.0.0":
+  version "1.0.5"
+  resolved "https://registry.yarnpkg.com/@types/estree/-/estree-1.0.5.tgz#a6ce3e556e00fd9895dd872dd172ad0d4bd687f4"
+  integrity sha512-/kYRxGDLWzHOB7q+wtSUQlFrtcdUccpfy+X+9iMBpHK8QLLhx2wIPYuS5DYtR9Wa/YlZAbIovy7qVdB1Aq6Lyw==
+
+"@types/invariant@^2.2.33":
+  version "2.2.37"
+  resolved "https://registry.yarnpkg.com/@types/invariant/-/invariant-2.2.37.tgz#1709741e534364d653c87dff22fc76fa94aa7bc0"
+  integrity sha512-IwpIMieE55oGWiXkQPSBY1nw1nFs6bsKXTFskNY8sdS17K24vyEBRQZEwlRS7ZmXCWnJcQtbxWzly+cODWGs2A==
+
+"@types/prop-types@*", "@types/prop-types@^15.7.3":
+  version "15.7.12"
+  resolved "https://registry.yarnpkg.com/@types/prop-types/-/prop-types-15.7.12.tgz#12bb1e2be27293c1406acb6af1c3f3a1481d98c6"
+  integrity sha512-5zvhXYtRNRluoE/jAp4GVsSduVUzNWKkOZrCDBWYtE7biZywwdC2AcEzg+cSMLFRfVgeAFqpfNabiPjxFddV1Q==
+
+"@types/react-transition-group@^4.4.1":
+  version "4.4.11"
+  resolved "https://registry.yarnpkg.com/@types/react-transition-group/-/react-transition-group-4.4.11.tgz#d963253a611d757de01ebb241143b1017d5d63d5"
+  integrity sha512-RM05tAniPZ5DZPzzNFP+DmrcOdD0efDUxMy3145oljWSl3x9ZV5vhme98gTxFrj2lhXvmGNnUiuDyJgY9IKkNA==
+  dependencies:
+    "@types/react" "*"
+
+"@types/react@*", "@types/react@>=16.14.8", "@types/react@>=16.9.11":
+  version "18.3.5"
+  resolved "https://registry.yarnpkg.com/@types/react/-/react-18.3.5.tgz#5f524c2ad2089c0ff372bbdabc77ca2c4dbadf8f"
+  integrity sha512-WeqMfGJLGuLCqHGYRGHxnKrXcTitc6L/nBUWfWPcTarG3t9PsquqUMuVeXZeca+mglY4Vo5GZjCi0A3Or2lnxA==
+  dependencies:
+    "@types/prop-types" "*"
+    csstype "^3.0.2"
+
+"@types/warning@^3.0.0":
+  version "3.0.3"
+  resolved "https://registry.yarnpkg.com/@types/warning/-/warning-3.0.3.tgz#d1884c8cc4a426d1ac117ca2611bf333834c6798"
+  integrity sha512-D1XC7WK8K+zZEveUPY+cf4+kgauk8N4eHr/XIHXGlGYkHLud6hK9lYfZk1ry1TNh798cZUCgb6MqGEG8DkJt6Q==
+
+"@vitejs/plugin-react@~4.3.1":
+  version "4.3.1"
+  resolved "https://registry.yarnpkg.com/@vitejs/plugin-react/-/plugin-react-4.3.1.tgz#d0be6594051ded8957df555ff07a991fb618b48e"
+  integrity sha512-m/V2syj5CuVnaxcUJOQRel/Wr31FFXRFlnOoq1TVtkCxsY5veGMTEmpWHndrhB2U8ScHtCQB1e+4hWYExQc6Lg==
+  dependencies:
+    "@babel/core" "^7.24.5"
+    "@babel/plugin-transform-react-jsx-self" "^7.24.5"
+    "@babel/plugin-transform-react-jsx-source" "^7.24.1"
+    "@types/babel__core" "^7.20.5"
+    react-refresh "^0.14.2"
+
+"@vitest/expect@2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/expect/-/expect-2.0.5.tgz#f3745a6a2c18acbea4d39f5935e913f40d26fa86"
+  integrity sha512-yHZtwuP7JZivj65Gxoi8upUN2OzHTi3zVfjwdpu2WrvCZPLwsJ2Ey5ILIPccoW23dd/zQBlJ4/dhi7DWNyXCpA==
+  dependencies:
+    "@vitest/spy" "2.0.5"
+    "@vitest/utils" "2.0.5"
+    chai "^5.1.1"
+    tinyrainbow "^1.2.0"
+
+"@vitest/pretty-format@2.0.5", "@vitest/pretty-format@^2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/pretty-format/-/pretty-format-2.0.5.tgz#91d2e6d3a7235c742e1a6cc50e7786e2f2979b1e"
+  integrity sha512-h8k+1oWHfwTkyTkb9egzwNMfJAEx4veaPSnMeKbVSjp4euqGSbQlm5+6VHwTr7u4FJslVVsUG5nopCaAYdOmSQ==
+  dependencies:
+    tinyrainbow "^1.2.0"
+
+"@vitest/runner@2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/runner/-/runner-2.0.5.tgz#89197e712bb93513537d6876995a4843392b2a84"
+  integrity sha512-TfRfZa6Bkk9ky4tW0z20WKXFEwwvWhRY+84CnSEtq4+3ZvDlJyY32oNTJtM7AW9ihW90tX/1Q78cb6FjoAs+ig==
+  dependencies:
+    "@vitest/utils" "2.0.5"
+    pathe "^1.1.2"
+
+"@vitest/snapshot@2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/snapshot/-/snapshot-2.0.5.tgz#a2346bc5013b73c44670c277c430e0334690a162"
+  integrity sha512-SgCPUeDFLaM0mIUHfaArq8fD2WbaXG/zVXjRupthYfYGzc8ztbFbu6dUNOblBG7XLMR1kEhS/DNnfCZ2IhdDew==
+  dependencies:
+    "@vitest/pretty-format" "2.0.5"
+    magic-string "^0.30.10"
+    pathe "^1.1.2"
+
+"@vitest/spy@2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/spy/-/spy-2.0.5.tgz#590fc07df84a78b8e9dd976ec2090920084a2b9f"
+  integrity sha512-c/jdthAhvJdpfVuaexSrnawxZz6pywlTPe84LUB2m/4t3rl2fTo9NFGBG4oWgaD+FTgDDV8hJ/nibT7IfH3JfA==
+  dependencies:
+    tinyspy "^3.0.0"
+
+"@vitest/utils@2.0.5":
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/@vitest/utils/-/utils-2.0.5.tgz#6f8307a4b6bc6ceb9270007f73c67c915944e926"
+  integrity sha512-d8HKbqIcya+GR67mkZbrzhS5kKhtp8dQLcmRZLGTscGVg7yImT82cIrhtn2L8+VujWcy6KZweApgNmPsTAO/UQ==
+  dependencies:
+    "@vitest/pretty-format" "2.0.5"
+    estree-walker "^3.0.3"
+    loupe "^3.1.1"
+    tinyrainbow "^1.2.0"
+
+agent-base@^7.0.2, agent-base@^7.1.0:
+  version "7.1.1"
+  resolved "https://registry.yarnpkg.com/agent-base/-/agent-base-7.1.1.tgz#bdbded7dfb096b751a2a087eeeb9664725b2e317"
+  integrity sha512-H0TSyFNDMomMNJQBn8wFV5YC/2eJ+VXECwOadZJT554xP6cODZHPX3H9QMQECxvrgiSOP1pHjy1sMWQVYJOUOA==
+  dependencies:
+    debug "^4.3.4"
+
+ansi-styles@^3.2.1:
+  version "3.2.1"
+  resolved "https://registry.yarnpkg.com/ansi-styles/-/ansi-styles-3.2.1.tgz#41fbb20243e50b12be0f04b8dedbf07520ce841d"
+  integrity sha512-VT0ZI6kZRdTh8YyJw3SMbYm/u+NqfsAxEpWO0Pf9sq8/e94WxxOpPKx9FR1FlyCtOVDNOQ+8ntlqFxiRc+r5qA==
+  dependencies:
+    color-convert "^1.9.0"
+
+anymatch@~3.1.2:
+  version "3.1.3"
+  resolved "https://registry.yarnpkg.com/anymatch/-/anymatch-3.1.3.tgz#790c58b19ba1720a84205b57c618d5ad8524973e"
+  integrity sha512-KMReFUr0B4t+D+OBkjR3KYqvocp2XaSzO55UcB6mgQMd3KbcE+mWTyvVV7D/zsdEbNnV6acZUutkiHQXvTr1Rw==
+  dependencies:
+    normalize-path "^3.0.0"
+    picomatch "^2.0.4"
+
+asap@~2.0.6:
+  version "2.0.6"
+  resolved "https://registry.yarnpkg.com/asap/-/asap-2.0.6.tgz#e50347611d7e690943208bbdafebcbc2fb866d46"
+  integrity sha512-BSHWgDSAiKs50o2Re8ppvp3seVHXSRM44cdSsT9FfNEUUZLOGWVCsiWaRPWM1Znn+mqZ1OfVZ3z3DWEzSp7hRA==
+
+assertion-error@^2.0.1:
+  version "2.0.1"
+  resolved "https://registry.yarnpkg.com/assertion-error/-/assertion-error-2.0.1.tgz#f641a196b335690b1070bf00b6e7593fec190bf7"
+  integrity sha512-Izi8RQcffqCeNVgFigKli1ssklIbpHnCYc6AknXGYoB6grJqyeby7jv12JUQgmTAnIDnbck1uxksT4dzN3PWBA==
+
+asynckit@^0.4.0:
+  version "0.4.0"
+  resolved "https://registry.yarnpkg.com/asynckit/-/asynckit-0.4.0.tgz#c79ed97f7f34cb8f2ba1bc9790bcc366474b4b79"
+  integrity sha512-Oei9OH4tRh0YqU3GxhX79dM/mwVgvbZJaSNaRk+bshkj0S5cfHcgYakreBjrHwatXKbz+IoIdYLxrKim2MjW0Q==
+
+axios-mock-adapter@~2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/axios-mock-adapter/-/axios-mock-adapter-2.0.0.tgz#91920c06e2e5733dd118ba079e4a12c58f3a68aa"
+  integrity sha512-D/K0J5Zm6KvaMTnsWrBQZWLzKN9GxUFZEa0mx2qeEHXDeTugCoplWehy8y36dj5vuSjhe1u/Dol8cZ8lzzmDew==
+  dependencies:
+    fast-deep-equal "^3.1.3"
+    is-buffer "^2.0.5"
+
+axios@~1.7.7:
+  version "1.7.7"
+  resolved "https://registry.yarnpkg.com/axios/-/axios-1.7.7.tgz#2f554296f9892a72ac8d8e4c5b79c14a91d0a47f"
+  integrity sha512-S4kL7XrjgBmvdGut0sN3yJxqYzrDOnivkBiN0OFs6hLiUam3UPvswUo0kqGyhqUZGEOytHyumEdXsAkgCOUf3Q==
+  dependencies:
+    follow-redirects "^1.15.6"
+    form-data "^4.0.0"
+    proxy-from-env "^1.1.0"
+
+binary-extensions@^2.0.0:
+  version "2.3.0"
+  resolved "https://registry.yarnpkg.com/binary-extensions/-/binary-extensions-2.3.0.tgz#f6e14a97858d327252200242d4ccfe522c445522"
+  integrity sha512-Ceh+7ox5qe7LJuLHoY0feh3pHuUDHAcRUeyL2VYghZwfpkNIy/+8Ocg0a3UuSoYzavmylwuLWQOf3hl0jjMMIw==
+
+braces@~3.0.2:
+  version "3.0.3"
+  resolved "https://registry.yarnpkg.com/braces/-/braces-3.0.3.tgz#490332f40919452272d55a8480adc0c441358789"
+  integrity sha512-yQbXgO/OSZVD2IsiLlro+7Hf6Q18EJrKSEsdoMzKePKXct3gvD8oLcOQdIzGupr5Fj+EDe8gO/lxc1BzfMpxvA==
+  dependencies:
+    fill-range "^7.1.1"
+
+browserslist@^4.23.1:
+  version "4.23.3"
+  resolved "https://registry.yarnpkg.com/browserslist/-/browserslist-4.23.3.tgz#debb029d3c93ebc97ffbc8d9cbb03403e227c800"
+  integrity sha512-btwCFJVjI4YWDNfau8RhZ+B1Q/VLoUITrm3RlP6y1tYGWIOa+InuYiRGXUBXo8nA1qKmHMyLB/iVQg5TT4eFoA==
+  dependencies:
+    caniuse-lite "^1.0.30001646"
+    electron-to-chromium "^1.5.4"
+    node-releases "^2.0.18"
+    update-browserslist-db "^1.1.0"
+
+"buildbot-data-js@link:../data-module":
+  version "4.0.0"
+
+"buildbot-plugin-support@link:../plugin_support":
+  version "1.0.0"
+
+"buildbot-ui@link:../ui":
+  version "0.1.0"
+  dependencies:
+    buildbot-data-js "link:../data-module"
+    react-icons "^5.3.0"
+
+cac@^6.7.14:
+  version "6.7.14"
+  resolved "https://registry.yarnpkg.com/cac/-/cac-6.7.14.tgz#804e1e6f506ee363cb0e3ccbb09cad5dd9870959"
+  integrity sha512-b6Ilus+c3RrdDk+JhLKUAQfzzgLEPy6wcXqS7f/xe1EETvsDP6GORG7SFuOs6cID5YkqchW/LXZbX5bc8j7ZcQ==
+
+caniuse-lite@^1.0.30001646:
+  version "1.0.30001655"
+  resolved "https://registry.yarnpkg.com/caniuse-lite/-/caniuse-lite-1.0.30001655.tgz#0ce881f5a19a2dcfda2ecd927df4d5c1684b982f"
+  integrity sha512-jRGVy3iSGO5Uutn2owlb5gR6qsGngTw9ZTb4ali9f3glshcNmJ2noam4Mo9zia5P9Dk3jNNydy7vQjuE5dQmfg==
+
+chai@^5.1.1:
+  version "5.1.1"
+  resolved "https://registry.yarnpkg.com/chai/-/chai-5.1.1.tgz#f035d9792a22b481ead1c65908d14bb62ec1c82c"
+  integrity sha512-pT1ZgP8rPNqUgieVaEY+ryQr6Q4HXNg8Ei9UnLUrjN4IA7dvQC5JB+/kxVcPNDHyBcc/26CXPkbNzq3qwrOEKA==
+  dependencies:
+    assertion-error "^2.0.1"
+    check-error "^2.1.1"
+    deep-eql "^5.0.1"
+    loupe "^3.1.0"
+    pathval "^2.0.0"
+
+chalk@^2.4.2:
+  version "2.4.2"
+  resolved "https://registry.yarnpkg.com/chalk/-/chalk-2.4.2.tgz#cd42541677a54333cf541a49108c1432b44c9424"
+  integrity sha512-Mti+f9lpJNcwF4tWV8/OrTTtF1gZi+f8FqlyAdouralcFWFQWF2+NgCHShjkCb+IFBLq9buZwE1xckQU4peSuQ==
+  dependencies:
+    ansi-styles "^3.2.1"
+    escape-string-regexp "^1.0.5"
+    supports-color "^5.3.0"
+
+check-error@^2.1.1:
+  version "2.1.1"
+  resolved "https://registry.yarnpkg.com/check-error/-/check-error-2.1.1.tgz#87eb876ae71ee388fa0471fe423f494be1d96ccc"
+  integrity sha512-OAlb+T7V4Op9OwdkjmguYRqncdlx5JiofwOAUkmTF+jNdHwzTaTs4sRAGpzLF3oOz5xAyDGrPgeIDFQmDOTiJw==
+
+"chokidar@>=3.0.0 <4.0.0":
+  version "3.6.0"
+  resolved "https://registry.yarnpkg.com/chokidar/-/chokidar-3.6.0.tgz#197c6cc669ef2a8dc5e7b4d97ee4e092c3eb0d5b"
+  integrity sha512-7VT13fmjotKpGipCW9JEQAusEPE+Ei8nl6/g4FBAmIm0GOOLMua9NDDo/DWp0ZAxCr3cPq5ZpBqmPAQgDda2Pw==
+  dependencies:
+    anymatch "~3.1.2"
+    braces "~3.0.2"
+    glob-parent "~5.1.2"
+    is-binary-path "~2.1.0"
+    is-glob "~4.0.1"
+    normalize-path "~3.0.0"
+    readdirp "~3.6.0"
+  optionalDependencies:
+    fsevents "~2.3.2"
+
+classnames@^2.3.1:
+  version "2.5.1"
+  resolved "https://registry.yarnpkg.com/classnames/-/classnames-2.5.1.tgz#ba774c614be0f016da105c858e7159eae8e7687b"
+  integrity sha512-saHYOzhIQs6wy2sVxTM6bUDsQO4F50V9RQ22qBpEdCW+I+/Wmke2HOl6lS6dTpdxVhb88/I6+Hs+438c3lfUow==
+
+color-convert@^1.9.0:
+  version "1.9.3"
+  resolved "https://registry.yarnpkg.com/color-convert/-/color-convert-1.9.3.tgz#bb71850690e1f136567de629d2d5471deda4c1e8"
+  integrity sha512-QfAUtd+vFdAtFQcC8CCyYt1fYWxSqAiK2cSD6zDB8N3cpsEBAvRxp9zOGg6G/SHHJYAT88/az/IuDGALsNVbGg==
+  dependencies:
+    color-name "1.1.3"
+
+color-name@1.1.3:
+  version "1.1.3"
+  resolved "https://registry.yarnpkg.com/color-name/-/color-name-1.1.3.tgz#a7d0558bd89c42f795dd42328f740831ca53bc25"
+  integrity sha512-72fSenhMw2HZMTVHeCA9KCmpEIbzWiQsjN+BHcBbS9vr1mtt+vJjPdksIBNUmKAW8TFUDPJK5SUU3QhE9NEXDw==
+
+combined-stream@^1.0.8:
+  version "1.0.8"
+  resolved "https://registry.yarnpkg.com/combined-stream/-/combined-stream-1.0.8.tgz#c3d45a8b34fd730631a110a8a2520682b31d5a7f"
+  integrity sha512-FQN4MRfuJeHf7cBbBMJFXhKSDq+2kAArBlmRBvcvFE5BB1HZKXtSFASDhdlz9zOYwxh8lDdnvmMOe/+5cdoEdg==
+  dependencies:
+    delayed-stream "~1.0.0"
+
+convert-source-map@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/convert-source-map/-/convert-source-map-2.0.0.tgz#4b560f649fc4e918dd0ab75cf4961e8bc882d82a"
+  integrity sha512-Kvp459HrV2FEJ1CAsi1Ku+MY3kasH19TFykTz2xWmMeq6bk2NU3XXvfJ+Q61m0xktWwt+1HSYf3JZsTms3aRJg==
+
+core-js@^3.19.2:
+  version "3.38.1"
+  resolved "https://registry.yarnpkg.com/core-js/-/core-js-3.38.1.tgz#aa375b79a286a670388a1a363363d53677c0383e"
+  integrity sha512-OP35aUorbU3Zvlx7pjsFdu1rGNnD4pgw/CWoYzRY3t2EzoVT7shKHY1dlAy3f41cGIO7ZDPQimhGFTlEYkG/Hw==
+
+cross-spawn@^7.0.3:
+  version "7.0.3"
+  resolved "https://registry.yarnpkg.com/cross-spawn/-/cross-spawn-7.0.3.tgz#f73a85b9d5d41d045551c177e2882d4ac85728a6"
+  integrity sha512-iRDPJKUPVEND7dHPO8rkbOnPpyDygcDFtWjpeWNCgy8WP2rXcxXL8TskReQl6OrB2G7+UJrags1q15Fudc7G6w==
+  dependencies:
+    path-key "^3.1.0"
+    shebang-command "^2.0.0"
+    which "^2.0.1"
+
+cssstyle@^4.0.1:
+  version "4.0.1"
+  resolved "https://registry.yarnpkg.com/cssstyle/-/cssstyle-4.0.1.tgz#ef29c598a1e90125c870525490ea4f354db0660a"
+  integrity sha512-8ZYiJ3A/3OkDd093CBT/0UKDWry7ak4BdPTFP2+QEP7cmhouyq/Up709ASSj2cK02BbZiMgk7kYjZNS4QP5qrQ==
+  dependencies:
+    rrweb-cssom "^0.6.0"
+
+csstype@^3.0.2:
+  version "3.1.3"
+  resolved "https://registry.yarnpkg.com/csstype/-/csstype-3.1.3.tgz#d80ff294d114fb0e6ac500fbf85b60137d7eff81"
+  integrity sha512-M1uQkMl8rQK/szD0LNhtqxIPLpimGm8sOBwU7lLnCpSbTyY3yeU1Vc7l4KT5zT4s/yOxHH5O7tIuuLOCnLADRw==
+
+data-urls@^5.0.0:
+  version "5.0.0"
+  resolved "https://registry.yarnpkg.com/data-urls/-/data-urls-5.0.0.tgz#2f76906bce1824429ffecb6920f45a0b30f00dde"
+  integrity sha512-ZYP5VBHshaDAiVZxjbRVcFJpc+4xGgT0bK3vzy1HLN8jTO975HEbuYzZJcHoQEY5K1a0z8YayJkyVETa08eNTg==
+  dependencies:
+    whatwg-mimetype "^4.0.0"
+    whatwg-url "^14.0.0"
+
+debug@4, debug@^4.1.0, debug@^4.3.1, debug@^4.3.4, debug@^4.3.5:
+  version "4.3.6"
+  resolved "https://registry.yarnpkg.com/debug/-/debug-4.3.6.tgz#2ab2c38fbaffebf8aa95fdfe6d88438c7a13c52b"
+  integrity sha512-O/09Bd4Z1fBrU4VzkhFqVgpPzaGbw6Sm9FEkBT1A/YBXQFGuuSxa1dN2nxgxS34JmKXqYx8CZAwEVoJFImUXIg==
+  dependencies:
+    ms "2.1.2"
+
+decimal.js@^10.4.3:
+  version "10.4.3"
+  resolved "https://registry.yarnpkg.com/decimal.js/-/decimal.js-10.4.3.tgz#1044092884d245d1b7f65725fa4ad4c6f781cc23"
+  integrity sha512-VBBaLc1MgL5XpzgIP7ny5Z6Nx3UrRkIViUkPUdtl9aya5amy3De1gsUUSB1g3+3sExYNjCAsAznmukyxCb1GRA==
+
+deep-eql@^5.0.1:
+  version "5.0.2"
+  resolved "https://registry.yarnpkg.com/deep-eql/-/deep-eql-5.0.2.tgz#4b756d8d770a9257300825d52a2c2cff99c3a341"
+  integrity sha512-h5k/5U50IJJFpzfL6nO9jaaumfjO/f2NjK/oYB2Djzm4p9L+3T9qWpZqZ2hAbLPuuYq9wrU08WQyBTL5GbPk5Q==
+
+delayed-stream@~1.0.0:
+  version "1.0.0"
+  resolved "https://registry.yarnpkg.com/delayed-stream/-/delayed-stream-1.0.0.tgz#df3ae199acadfb7d440aaae0b29e2272b24ec619"
+  integrity sha512-ZySD7Nf91aLB0RxL4KGrKHBXl7Eds1DAmEdcoVawXnLD7SDhpNgtuII2aAkg7a7QS41jxPSZ17p4VdGnMHk3MQ==
+
+dequal@^2.0.3:
+  version "2.0.3"
+  resolved "https://registry.yarnpkg.com/dequal/-/dequal-2.0.3.tgz#2644214f1997d39ed0ee0ece72335490a7ac67be"
+  integrity sha512-0je+qPKHEMohvfRTCEo3CrPG6cAzAYgmzKyxRiYSSDkS6eGJdyVJm7WaYA5ECaAD9wLB2T4EEeymA5aFVcYXCA==
+
+dom-helpers@^5.0.1, dom-helpers@^5.2.0, dom-helpers@^5.2.1:
+  version "5.2.1"
+  resolved "https://registry.yarnpkg.com/dom-helpers/-/dom-helpers-5.2.1.tgz#d9400536b2bf8225ad98fe052e029451ac40e902"
+  integrity sha512-nRCa7CK3VTrM2NmGkIy4cbK7IZlgBE/PYMn55rrXefr5xXDP0LdtfPnblFDoVdcAfslJ7or6iqAUnx0CCGIWQA==
+  dependencies:
+    "@babel/runtime" "^7.8.7"
+    csstype "^3.0.2"
+
+electron-to-chromium@^1.5.4:
+  version "1.5.13"
+  resolved "https://registry.yarnpkg.com/electron-to-chromium/-/electron-to-chromium-1.5.13.tgz#1abf0410c5344b2b829b7247e031f02810d442e6"
+  integrity sha512-lbBcvtIJ4J6sS4tb5TLp1b4LyfCdMkwStzXPyAgVgTRAsep4bvrAGaBOP7ZJtQMNJpSQ9SqG4brWOroNaQtm7Q==
+
+entities@^4.4.0:
+  version "4.5.0"
+  resolved "https://registry.yarnpkg.com/entities/-/entities-4.5.0.tgz#5d268ea5e7113ec74c4d033b79ea5a35a488fb48"
+  integrity sha512-V0hjH4dGPh9Ao5p0MoRY6BVqtwCjhz6vI5LT8AJ55H+4g9/4vbHx1I54fS0XuclLhDHArPQCiMjDxjaL8fPxhw==
+
+esbuild@^0.21.3:
+  version "0.21.5"
+  resolved "https://registry.yarnpkg.com/esbuild/-/esbuild-0.21.5.tgz#9ca301b120922959b766360d8ac830da0d02997d"
+  integrity sha512-mg3OPMV4hXywwpoDxu3Qda5xCKQi+vCTZq8S9J/EpkhB2HzKXq4SNFZE3+NK93JYxc8VMSep+lOUSC/RVKaBqw==
+  optionalDependencies:
+    "@esbuild/aix-ppc64" "0.21.5"
+    "@esbuild/android-arm" "0.21.5"
+    "@esbuild/android-arm64" "0.21.5"
+    "@esbuild/android-x64" "0.21.5"
+    "@esbuild/darwin-arm64" "0.21.5"
+    "@esbuild/darwin-x64" "0.21.5"
+    "@esbuild/freebsd-arm64" "0.21.5"
+    "@esbuild/freebsd-x64" "0.21.5"
+    "@esbuild/linux-arm" "0.21.5"
+    "@esbuild/linux-arm64" "0.21.5"
+    "@esbuild/linux-ia32" "0.21.5"
+    "@esbuild/linux-loong64" "0.21.5"
+    "@esbuild/linux-mips64el" "0.21.5"
+    "@esbuild/linux-ppc64" "0.21.5"
+    "@esbuild/linux-riscv64" "0.21.5"
+    "@esbuild/linux-s390x" "0.21.5"
+    "@esbuild/linux-x64" "0.21.5"
+    "@esbuild/netbsd-x64" "0.21.5"
+    "@esbuild/openbsd-x64" "0.21.5"
+    "@esbuild/sunos-x64" "0.21.5"
+    "@esbuild/win32-arm64" "0.21.5"
+    "@esbuild/win32-ia32" "0.21.5"
+    "@esbuild/win32-x64" "0.21.5"
+
+escalade@^3.1.2:
+  version "3.2.0"
+  resolved "https://registry.yarnpkg.com/escalade/-/escalade-3.2.0.tgz#011a3f69856ba189dffa7dc8fcce99d2a87903e5"
+  integrity sha512-WUj2qlxaQtO4g6Pq5c29GTcWGDyd8itL8zTlipgECz3JesAiiOKotd8JU6otB3PACgG6xkJUyVhboMS+bje/jA==
+
+escape-string-regexp@^1.0.5:
+  version "1.0.5"
+  resolved "https://registry.yarnpkg.com/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz#1b61c0562190a8dff6ae3bb2cf0200ca130b86d4"
+  integrity sha512-vbRorB5FUQWvla16U8R/qgaFIya2qGzwDrNmCZuYKrbdSUMG6I1ZCGQRefkRVhuOkIGVne7BQ35DSfo1qvJqFg==
+
+estree-walker@^3.0.3:
+  version "3.0.3"
+  resolved "https://registry.yarnpkg.com/estree-walker/-/estree-walker-3.0.3.tgz#67c3e549ec402a487b4fc193d1953a524752340d"
+  integrity sha512-7RUKfXgSMMkzt6ZuXmqapOurLGPPfgj6l9uRZ7lRGolvk0y2yocc35LdcxKC5PQZdn2DMqioAQ2NoWcrTKmm6g==
+  dependencies:
+    "@types/estree" "^1.0.0"
+
+execa@^8.0.1:
+  version "8.0.1"
+  resolved "https://registry.yarnpkg.com/execa/-/execa-8.0.1.tgz#51f6a5943b580f963c3ca9c6321796db8cc39b8c"
+  integrity sha512-VyhnebXciFV2DESc+p6B+y0LjSm0krU4OgJN44qFAhBY0TJ+1V61tYD2+wHusZ6F9n5K+vl8k0sTy7PEfV4qpg==
+  dependencies:
+    cross-spawn "^7.0.3"
+    get-stream "^8.0.1"
+    human-signals "^5.0.0"
+    is-stream "^3.0.0"
+    merge-stream "^2.0.0"
+    npm-run-path "^5.1.0"
+    onetime "^6.0.0"
+    signal-exit "^4.1.0"
+    strip-final-newline "^3.0.0"
+
+fast-deep-equal@^3.1.3:
+  version "3.1.3"
+  resolved "https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz#3a7d56b559d6cbc3eb512325244e619a65c6c525"
+  integrity sha512-f3qQ9oQy9j2AhBe/H9VC91wLmKBCCU/gDOnKNAYG5hswO7BLKj09Hc5HYNz9cGI++xlpDCIgDaitVs03ATR84Q==
+
+fill-range@^7.1.1:
+  version "7.1.1"
+  resolved "https://registry.yarnpkg.com/fill-range/-/fill-range-7.1.1.tgz#44265d3cac07e3ea7dc247516380643754a05292"
+  integrity sha512-YsGpe3WHLK8ZYi4tWDg2Jy3ebRz2rXowDxnld4bkQB00cc/1Zw9AWnC0i9ztDJitivtQvaI9KaLyKrc+hBW0yg==
+  dependencies:
+    to-regex-range "^5.0.1"
+
+follow-redirects@^1.15.6:
+  version "1.15.7"
+  resolved "https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.15.7.tgz#87248a048fc4eeebfb2389d6aef79028da179690"
+  integrity sha512-aAW9al/NMw4COcZnwgUaG8kAjBUXq/El+1R11e9RDHAIlxa1fb1b5SP0K6BbMoNgWdmJ/kXAwoTlVDlUN3OTDw==
+
+form-data@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/form-data/-/form-data-4.0.0.tgz#93919daeaf361ee529584b9b31664dc12c9fa452"
+  integrity sha512-ETEklSGi5t0QMZuiXoA/Q6vcnxcLQP5vdugSpuAyi6SVGi2clPPp+xgEhuMaHC+zGgn31Kd235W35f7Hykkaww==
+  dependencies:
+    asynckit "^0.4.0"
+    combined-stream "^1.0.8"
+    mime-types "^2.1.12"
+
+fsevents@~2.3.2, fsevents@~2.3.3:
+  version "2.3.3"
+  resolved "https://registry.yarnpkg.com/fsevents/-/fsevents-2.3.3.tgz#cac6407785d03675a2a5e1a5305c697b347d90d6"
+  integrity sha512-5xoDfX+fL7faATnagmWPpbFtwh/R77WmMMqqHGS65C3vvB0YHrgF+B1YmZ3441tMj5n63k0212XNoJwzlhffQw==
+
+gensync@^1.0.0-beta.2:
+  version "1.0.0-beta.2"
+  resolved "https://registry.yarnpkg.com/gensync/-/gensync-1.0.0-beta.2.tgz#32a6ee76c3d7f52d46b2b1ae5d93fea8580a25e0"
+  integrity sha512-3hN7NaskYvMDLQY55gnW3NQ+mesEAepTqlg+VEbj7zzqEMBVNhzcGYYeqFo/TlYz6eQiFcp1HcsCZO+nGgS8zg==
+
+get-func-name@^2.0.1:
+  version "2.0.2"
+  resolved "https://registry.yarnpkg.com/get-func-name/-/get-func-name-2.0.2.tgz#0d7cf20cd13fda808669ffa88f4ffc7a3943fc41"
+  integrity sha512-8vXOvuE167CtIc3OyItco7N/dpRtBbYOsPsXCz7X/PMnlGjYjSGuZJgM1Y7mmew7BKf9BqvLX2tnOVy1BBUsxQ==
+
+get-stream@^8.0.1:
+  version "8.0.1"
+  resolved "https://registry.yarnpkg.com/get-stream/-/get-stream-8.0.1.tgz#def9dfd71742cd7754a7761ed43749a27d02eca2"
+  integrity sha512-VaUJspBffn/LMCJVoMvSAdmscJyS1auj5Zulnn5UoYcY531UWmdwhRWkcGKnGU93m5HSXP9LP2usOryrBtQowA==
+
+glob-parent@~5.1.2:
+  version "5.1.2"
+  resolved "https://registry.yarnpkg.com/glob-parent/-/glob-parent-5.1.2.tgz#869832c58034fe68a4093c17dc15e8340d8401c4"
+  integrity sha512-AOIgSQCepiJYwP3ARnGx+5VnTu2HBYdzbGP45eLw1vr3zB3vZLeyed1sC9hnbcOc9/SrMyM5RPQrkGz4aS9Zow==
+  dependencies:
+    is-glob "^4.0.1"
+
+globals@^11.1.0:
+  version "11.12.0"
+  resolved "https://registry.yarnpkg.com/globals/-/globals-11.12.0.tgz#ab8795338868a0babd8525758018c2a7eb95c42e"
+  integrity sha512-WOBp/EEGUiIsJSp7wcv/y6MO+lV9UoncWqxuFfm8eBwzWNgyfBd6Gz+IeKQ9jCmyhoH99g15M3T+QaVHFjizVA==
+
+has-flag@^3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/has-flag/-/has-flag-3.0.0.tgz#b5d454dc2199ae225699f3467e5a07f3b955bafd"
+  integrity sha512-sKJf1+ceQBr4SMkvQnBDNDtf4TXpVhVGateu0t918bl30FnbE2m4vNLX+VWe/dpjlb+HugGYzW7uQXH98HPEYw==
+
+html-encoding-sniffer@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/html-encoding-sniffer/-/html-encoding-sniffer-4.0.0.tgz#696df529a7cfd82446369dc5193e590a3735b448"
+  integrity sha512-Y22oTqIU4uuPgEemfz7NDJz6OeKf12Lsu+QC+s3BVpda64lTiMYCyGwg5ki4vFxkMwQdeZDl2adZoqUgdFuTgQ==
+  dependencies:
+    whatwg-encoding "^3.1.1"
+
+http-proxy-agent@^7.0.2:
+  version "7.0.2"
+  resolved "https://registry.yarnpkg.com/http-proxy-agent/-/http-proxy-agent-7.0.2.tgz#9a8b1f246866c028509486585f62b8f2c18c270e"
+  integrity sha512-T1gkAiYYDWYx3V5Bmyu7HcfcvL7mUrTWiM6yOfa3PIphViJ/gFPbvidQ+veqSOHci/PxBcDabeUNCzpOODJZig==
+  dependencies:
+    agent-base "^7.1.0"
+    debug "^4.3.4"
+
+https-proxy-agent@^7.0.5:
+  version "7.0.5"
+  resolved "https://registry.yarnpkg.com/https-proxy-agent/-/https-proxy-agent-7.0.5.tgz#9e8b5013873299e11fab6fd548405da2d6c602b2"
+  integrity sha512-1e4Wqeblerz+tMKPIq2EMGiiWW1dIjZOksyHWSUm1rmuvw/how9hBHZ38lAGj5ID4Ik6EdkOw7NmWPy6LAwalw==
+  dependencies:
+    agent-base "^7.0.2"
+    debug "4"
+
+human-signals@^5.0.0:
+  version "5.0.0"
+  resolved "https://registry.yarnpkg.com/human-signals/-/human-signals-5.0.0.tgz#42665a284f9ae0dade3ba41ebc37eb4b852f3a28"
+  integrity sha512-AXcZb6vzzrFAUE61HnN4mpLqd/cSIwNQjtNWR0euPm6y0iqx3G4gOXaIDdtdDwZmhwe82LA6+zinmW4UBWVePQ==
+
+iconv-lite@0.6.3:
+  version "0.6.3"
+  resolved "https://registry.yarnpkg.com/iconv-lite/-/iconv-lite-0.6.3.tgz#a52f80bf38da1952eb5c681790719871a1a72501"
+  integrity sha512-4fCk79wshMdzMp2rH06qWrJE4iolqLhCUH+OiuIgU++RB0+94NlDL81atO7GX55uUKueo0txHNtvEyI6D7WdMw==
+  dependencies:
+    safer-buffer ">= 2.1.2 < 3.0.0"
+
+immutable@^4.0.0:
+  version "4.3.7"
+  resolved "https://registry.yarnpkg.com/immutable/-/immutable-4.3.7.tgz#c70145fc90d89fb02021e65c84eb0226e4e5a381"
+  integrity sha512-1hqclzwYwjRDFLjcFxOM5AYkkG0rpFPpr1RLPMEuGczoS7YA8gLhy8SWXYRAA/XwfEHpfo3cw5JGioS32fnMRw==
+
+invariant@^2.2.4:
+  version "2.2.4"
+  resolved "https://registry.yarnpkg.com/invariant/-/invariant-2.2.4.tgz#610f3c92c9359ce1db616e538008d23ff35158e6"
+  integrity sha512-phJfQVBuaJM5raOpJjSfkiD6BpbCE4Ns//LaXl6wGYtUBY83nWS6Rf9tXm2e8VaK60JEjYldbPif/A2B1C2gNA==
+  dependencies:
+    loose-envify "^1.0.0"
+
+is-binary-path@~2.1.0:
+  version "2.1.0"
+  resolved "https://registry.yarnpkg.com/is-binary-path/-/is-binary-path-2.1.0.tgz#ea1f7f3b80f064236e83470f86c09c254fb45b09"
+  integrity sha512-ZMERYes6pDydyuGidse7OsHxtbI7WVeUEozgR/g7rd0xUimYNlvZRE/K2MgZTjWy725IfelLeVcEM97mmtRGXw==
+  dependencies:
+    binary-extensions "^2.0.0"
+
+is-buffer@^2.0.5:
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/is-buffer/-/is-buffer-2.0.5.tgz#ebc252e400d22ff8d77fa09888821a24a658c191"
+  integrity sha512-i2R6zNFDwgEHJyQUtJEk0XFi1i0dPFn/oqjK3/vPCcDeJvW5NQ83V8QbicfF1SupOaB0h8ntgBC2YiE7dfyctQ==
+
+is-extglob@^2.1.1:
+  version "2.1.1"
+  resolved "https://registry.yarnpkg.com/is-extglob/-/is-extglob-2.1.1.tgz#a88c02535791f02ed37c76a1b9ea9773c833f8c2"
+  integrity sha512-SbKbANkN603Vi4jEZv49LeVJMn4yGwsbzZworEoyEiutsN3nJYdbO36zfhGJ6QEDpOZIFkDtnq5JRxmvl3jsoQ==
+
+is-glob@^4.0.1, is-glob@~4.0.1:
+  version "4.0.3"
+  resolved "https://registry.yarnpkg.com/is-glob/-/is-glob-4.0.3.tgz#64f61e42cbbb2eec2071a9dac0b28ba1e65d5084"
+  integrity sha512-xelSayHH36ZgE7ZWhli7pW34hNbNl8Ojv5KVmkJD4hBdD3th8Tfk9vYasLM+mXWOZhFkgZfxhLSnrwRr4elSSg==
+  dependencies:
+    is-extglob "^2.1.1"
+
+is-number@^7.0.0:
+  version "7.0.0"
+  resolved "https://registry.yarnpkg.com/is-number/-/is-number-7.0.0.tgz#7535345b896734d5f80c4d06c50955527a14f12b"
+  integrity sha512-41Cifkg6e8TylSpdtTpeLVMqvSBEVzTttHvERD741+pnZ8ANv0004MRL43QKPDlK9cGvNp6NZWZUBlbGXYxxng==
+
+is-potential-custom-element-name@^1.0.1:
+  version "1.0.1"
+  resolved "https://registry.yarnpkg.com/is-potential-custom-element-name/-/is-potential-custom-element-name-1.0.1.tgz#171ed6f19e3ac554394edf78caa05784a45bebb5"
+  integrity sha512-bCYeRA2rVibKZd+s2625gGnGF/t7DSqDs4dP7CrLA1m7jKWz6pps0LpYLJN8Q64HtmPKJ1hrN3nzPNKFEKOUiQ==
+
+is-stream@^3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/is-stream/-/is-stream-3.0.0.tgz#e6bfd7aa6bef69f4f472ce9bb681e3e57b4319ac"
+  integrity sha512-LnQR4bZ9IADDRSkvpqMGvt/tEJWclzklNgSw48V5EAaAeDd6qGvN8ei6k5p0tvxSR171VmGyHuTiAOfxAbr8kA==
+
+isexe@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/isexe/-/isexe-2.0.0.tgz#e8fbf374dc556ff8947a10dcb0572d633f2cfa10"
+  integrity sha512-RHxMLp9lnKHGHRng9QFhRCMbYAcVpn69smSGcq3f36xjgVVWThj4qqLbTLlq7Ssj8B+fIQ1EuCEGI2lKsyQeIw==
+
+"js-tokens@^3.0.0 || ^4.0.0", js-tokens@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/js-tokens/-/js-tokens-4.0.0.tgz#19203fb59991df98e3a287050d4647cdeaf32499"
+  integrity sha512-RdJUflcE3cUzKiMqQgsCu06FPu9UdIJO0beYbPhHN4k6apgJtifcoCtT9bcxOpYBtpD2kCM6Sbzg4CausW/PKQ==
+
+jsdom@^25.0.0:
+  version "25.0.0"
+  resolved "https://registry.yarnpkg.com/jsdom/-/jsdom-25.0.0.tgz#d1612b4ddab85af56821b2f731e15faae135f4e1"
+  integrity sha512-OhoFVT59T7aEq75TVw9xxEfkXgacpqAhQaYgP9y/fDqWQCMB/b1H66RfmPm/MaeaAIU9nDwMOVTlPN51+ao6CQ==
+  dependencies:
+    cssstyle "^4.0.1"
+    data-urls "^5.0.0"
+    decimal.js "^10.4.3"
+    form-data "^4.0.0"
+    html-encoding-sniffer "^4.0.0"
+    http-proxy-agent "^7.0.2"
+    https-proxy-agent "^7.0.5"
+    is-potential-custom-element-name "^1.0.1"
+    nwsapi "^2.2.12"
+    parse5 "^7.1.2"
+    rrweb-cssom "^0.7.1"
+    saxes "^6.0.0"
+    symbol-tree "^3.2.4"
+    tough-cookie "^4.1.4"
+    w3c-xmlserializer "^5.0.0"
+    webidl-conversions "^7.0.0"
+    whatwg-encoding "^3.1.1"
+    whatwg-mimetype "^4.0.0"
+    whatwg-url "^14.0.0"
+    ws "^8.18.0"
+    xml-name-validator "^5.0.0"
+
+jsesc@^2.5.1:
+  version "2.5.2"
+  resolved "https://registry.yarnpkg.com/jsesc/-/jsesc-2.5.2.tgz#80564d2e483dacf6e8ef209650a67df3f0c283a4"
+  integrity sha512-OYu7XEzjkCQ3C5Ps3QIZsQfNpqoJyZZA99wd9aWd05NCtC5pWOkShK2mkL6HXQR6/Cy2lbNdPlZBpuQHXE63gA==
+
+json5@^2.2.3:
+  version "2.2.3"
+  resolved "https://registry.yarnpkg.com/json5/-/json5-2.2.3.tgz#78cd6f1a19bdc12b73db5ad0c61efd66c1e29283"
+  integrity sha512-XmOWe7eyHYH14cLdVPoyg+GOH3rYX++KpzrylJwSW98t3Nk+U8XOl8FWKOgwtzdb8lXGf6zYwDUzeHMWfxasyg==
+
+loose-envify@^1.0.0, loose-envify@^1.1.0, loose-envify@^1.4.0:
+  version "1.4.0"
+  resolved "https://registry.yarnpkg.com/loose-envify/-/loose-envify-1.4.0.tgz#71ee51fa7be4caec1a63839f7e682d8132d30caf"
+  integrity sha512-lyuxPGr/Wfhrlem2CL/UcnUc1zcqKAImBDzukY7Y5F/yQiNdko6+fRLevlw1HgMySw7f611UIY408EtxRSoK3Q==
+  dependencies:
+    js-tokens "^3.0.0 || ^4.0.0"
+
+loupe@^3.1.0, loupe@^3.1.1:
+  version "3.1.1"
+  resolved "https://registry.yarnpkg.com/loupe/-/loupe-3.1.1.tgz#71d038d59007d890e3247c5db97c1ec5a92edc54"
+  integrity sha512-edNu/8D5MKVfGVFRhFf8aAxiTM6Wumfz5XsaatSxlD3w4R1d/WEKUTydCdPGbl9K7QG/Ca3GnDV2sIKIpXRQcw==
+  dependencies:
+    get-func-name "^2.0.1"
+
+lru-cache@^5.1.1:
+  version "5.1.1"
+  resolved "https://registry.yarnpkg.com/lru-cache/-/lru-cache-5.1.1.tgz#1da27e6710271947695daf6848e847f01d84b920"
+  integrity sha512-KpNARQA3Iwv+jTA0utUVVbrh+Jlrr1Fv0e56GGzAFOXN7dk/FviaDW8LHmK52DlcH4WP2n6gI8vN1aesBFgo9w==
+  dependencies:
+    yallist "^3.0.2"
+
+magic-string@^0.30.10:
+  version "0.30.11"
+  resolved "https://registry.yarnpkg.com/magic-string/-/magic-string-0.30.11.tgz#301a6f93b3e8c2cb13ac1a7a673492c0dfd12954"
+  integrity sha512-+Wri9p0QHMy+545hKww7YAu5NyzF8iomPL/RQazugQ9+Ez4Ic3mERMd8ZTX5rfK944j+560ZJi8iAwgak1Ac7A==
+  dependencies:
+    "@jridgewell/sourcemap-codec" "^1.5.0"
+
+merge-stream@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/merge-stream/-/merge-stream-2.0.0.tgz#52823629a14dd00c9770fb6ad47dc6310f2c1f60"
+  integrity sha512-abv/qOcuPfk3URPfDzmZU1LKmuw8kT+0nIHvKrKgFrwifol/doWcdA4ZqsWQ8ENrFKkd67Mfpo/LovbIUsbt3w==
+
+mime-db@1.52.0:
+  version "1.52.0"
+  resolved "https://registry.yarnpkg.com/mime-db/-/mime-db-1.52.0.tgz#bbabcdc02859f4987301c856e3387ce5ec43bf70"
+  integrity sha512-sPU4uV7dYlvtWJxwwxHD0PuihVNiE7TyAbQ5SWxDCB9mUYvOgroQOwYQQOKPJ8CIbE+1ETVlOoK1UC2nU3gYvg==
+
+mime-types@^2.1.12:
+  version "2.1.35"
+  resolved "https://registry.yarnpkg.com/mime-types/-/mime-types-2.1.35.tgz#381a871b62a734450660ae3deee44813f70d959a"
+  integrity sha512-ZDY+bPm5zTTF+YpCrAU9nK0UgICYPT0QtT1NZWFv4s++TNkcgVaT0g6+4R2uI4MjQjzysHB1zxuWL50hzaeXiw==
+  dependencies:
+    mime-db "1.52.0"
+
+mimic-fn@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/mimic-fn/-/mimic-fn-4.0.0.tgz#60a90550d5cb0b239cca65d893b1a53b29871ecc"
+  integrity sha512-vqiC06CuhBTUdZH+RYl8sFrL096vA45Ok5ISO6sE/Mr1jRbGH4Csnhi8f3wKVl7x8mO4Au7Ir9D3Oyv1VYMFJw==
+
+mobx-react-lite@^4.0.7:
+  version "4.0.7"
+  resolved "https://registry.yarnpkg.com/mobx-react-lite/-/mobx-react-lite-4.0.7.tgz#f4e21e18d05c811010dcb1d3007e797924c4d90b"
+  integrity sha512-RjwdseshK9Mg8On5tyJZHtGD+J78ZnCnRaxeQDSiciKVQDUbfZcXhmld0VMxAwvcTnPEHZySGGewm467Fcpreg==
+  dependencies:
+    use-sync-external-store "^1.2.0"
+
+mobx-react@^9.1.1:
+  version "9.1.1"
+  resolved "https://registry.yarnpkg.com/mobx-react/-/mobx-react-9.1.1.tgz#b96e0d5d74a3d02fc62729fd344b2a3ad2a88aae"
+  integrity sha512-gVV7AdSrAAxqXOJ2bAbGa5TkPqvITSzaPiiEkzpW4rRsMhSec7C2NBCJYILADHKp2tzOAIETGRsIY0UaCV5aEw==
+  dependencies:
+    mobx-react-lite "^4.0.7"
+
+mobx@^6.6.1:
+  version "6.13.1"
+  resolved "https://registry.yarnpkg.com/mobx/-/mobx-6.13.1.tgz#76c41aa675199f75b84a257e4bec8ff839e33259"
+  integrity sha512-ekLRxgjWJr8hVxj9ZKuClPwM/iHckx3euIJ3Np7zLVNtqJvfbbq7l370W/98C8EabdQ1pB5Jd3BbDWxJPNnaOg==
+
+moment@^2.29.4:
+  version "2.30.1"
+  resolved "https://registry.yarnpkg.com/moment/-/moment-2.30.1.tgz#f8c91c07b7a786e30c59926df530b4eac96974ae"
+  integrity sha512-uEmtNhbDOrWPFS+hdjFCBfy9f2YoyzRpwcl+DqpC6taX21FzsTLQVbMV/W7PzNSX6x/bhC1zA3c2UQ5NzH6how==
+
+ms@2.1.2:
+  version "2.1.2"
+  resolved "https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz#d09d1f357b443f493382a8eb3ccd183872ae6009"
+  integrity sha512-sGkPx+VjMtmA6MX27oA4FBFELFCZZ4S4XqeGOXCv68tT+jb3vk/RyaKWP0PTKyWtmLSM0b+adUTEvbs1PEaH2w==
+
+nanoid@^3.3.7:
+  version "3.3.7"
+  resolved "https://registry.yarnpkg.com/nanoid/-/nanoid-3.3.7.tgz#d0c301a691bc8d54efa0a2226ccf3fe2fd656bd8"
+  integrity sha512-eSRppjcPIatRIMC1U6UngP8XFcz8MQWGQdt1MTBQ7NaAmvXDfvNxbvWV3x2y6CdEUciCSsDHDQZbhYaB8QEo2g==
+
+node-releases@^2.0.18:
+  version "2.0.18"
+  resolved "https://registry.yarnpkg.com/node-releases/-/node-releases-2.0.18.tgz#f010e8d35e2fe8d6b2944f03f70213ecedc4ca3f"
+  integrity sha512-d9VeXT4SJ7ZeOqGX6R5EM022wpL+eWPooLI+5UpWn2jCT1aosUQEhQP214x33Wkwx3JQMvIm+tIoVOdodFS40g==
+
+normalize-path@^3.0.0, normalize-path@~3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/normalize-path/-/normalize-path-3.0.0.tgz#0dcd69ff23a1c9b11fd0978316644a0388216a65"
+  integrity sha512-6eZs5Ls3WtCisHWp9S2GUy8dqkpGi4BVSz3GaqiE6ezub0512ESztXUwUB6C6IKbQkY2Pnb/mD4WYojCRwcwLA==
+
+npm-run-path@^5.1.0:
+  version "5.3.0"
+  resolved "https://registry.yarnpkg.com/npm-run-path/-/npm-run-path-5.3.0.tgz#e23353d0ebb9317f174e93417e4a4d82d0249e9f"
+  integrity sha512-ppwTtiJZq0O/ai0z7yfudtBpWIoxM8yE6nHi1X47eFR2EWORqfbu6CnPlNsjeN683eT0qG6H/Pyf9fCcvjnnnQ==
+  dependencies:
+    path-key "^4.0.0"
+
+nwsapi@^2.2.12:
+  version "2.2.12"
+  resolved "https://registry.yarnpkg.com/nwsapi/-/nwsapi-2.2.12.tgz#fb6af5c0ec35b27b4581eb3bbad34ec9e5c696f8"
+  integrity sha512-qXDmcVlZV4XRtKFzddidpfVP4oMSGhga+xdMc25mv8kaLUHtgzCDhUxkrN8exkGdTlLNaXj7CV3GtON7zuGZ+w==
+
+object-assign@^4.1.1:
+  version "4.1.1"
+  resolved "https://registry.yarnpkg.com/object-assign/-/object-assign-4.1.1.tgz#2109adc7965887cfc05cbbd442cac8bfbb360863"
+  integrity sha512-rJgTQnkUnH1sFw8yT6VSU3zD3sWmu6sZhIseY8VX+GRu3P6F7Fu+JNDoXfklElbLJSnc3FUQHVe4cU5hj+BcUg==
+
+onetime@^6.0.0:
+  version "6.0.0"
+  resolved "https://registry.yarnpkg.com/onetime/-/onetime-6.0.0.tgz#7c24c18ed1fd2e9bca4bd26806a33613c77d34b4"
+  integrity sha512-1FlR+gjXK7X+AsAHso35MnyN5KqGwJRi/31ft6x0M194ht7S+rWAvd7PHss9xSKMzE0asv1pyIHaJYq+BbacAQ==
+  dependencies:
+    mimic-fn "^4.0.0"
+
+parse5@^7.1.2:
+  version "7.1.2"
+  resolved "https://registry.yarnpkg.com/parse5/-/parse5-7.1.2.tgz#0736bebbfd77793823240a23b7fc5e010b7f8e32"
+  integrity sha512-Czj1WaSVpaoj0wbhMzLmWD69anp2WH7FXMB9n1Sy8/ZFF9jolSQVMu1Ij5WIyGmcBmhk7EOndpO4mIpihVqAXw==
+  dependencies:
+    entities "^4.4.0"
+
+path-key@^3.1.0:
+  version "3.1.1"
+  resolved "https://registry.yarnpkg.com/path-key/-/path-key-3.1.1.tgz#581f6ade658cbba65a0d3380de7753295054f375"
+  integrity sha512-ojmeN0qd+y0jszEtoY48r0Peq5dwMEkIlCOu6Q5f41lfkswXuKtYrhgoTpLnyIcHm24Uhqx+5Tqm2InSwLhE6Q==
+
+path-key@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/path-key/-/path-key-4.0.0.tgz#295588dc3aee64154f877adb9d780b81c554bf18"
+  integrity sha512-haREypq7xkM7ErfgIyA0z+Bj4AGKlMSdlQE2jvJo6huWD1EdkKYV+G/T4nq0YEF2vgTT8kqMFKo1uHn950r4SQ==
+
+pathe@^1.1.2:
+  version "1.1.2"
+  resolved "https://registry.yarnpkg.com/pathe/-/pathe-1.1.2.tgz#6c4cb47a945692e48a1ddd6e4094d170516437ec"
+  integrity sha512-whLdWMYL2TwI08hn8/ZqAbrVemu0LNaNNJZX73O6qaIdCTfXutsLhMkjdENX0qhsQ9uIimo4/aQOmXkoon2nDQ==
+
+pathval@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/pathval/-/pathval-2.0.0.tgz#7e2550b422601d4f6b8e26f1301bc8f15a741a25"
+  integrity sha512-vE7JKRyES09KiunauX7nd2Q9/L7lhok4smP9RZTDeD4MVs72Dp2qNFVz39Nz5a0FVEW0BJR6C0DYrq6unoziZA==
+
+performance-now@^2.1.0:
+  version "2.1.0"
+  resolved "https://registry.yarnpkg.com/performance-now/-/performance-now-2.1.0.tgz#6309f4e0e5fa913ec1c69307ae364b4b377c9e7b"
+  integrity sha512-7EAHlyLHI56VEIdK57uwHdHKIaAGbnXPiw0yWbarQZOKaKpvUIgW0jWRVLiatnM+XXlSwsanIBH/hzGMJulMow==
+
+picocolors@^1.0.0, picocolors@^1.0.1:
+  version "1.1.0"
+  resolved "https://registry.yarnpkg.com/picocolors/-/picocolors-1.1.0.tgz#5358b76a78cde483ba5cef6a9dc9671440b27d59"
+  integrity sha512-TQ92mBOW0l3LeMeyLV6mzy/kWr8lkd/hp3mTg7wYK7zJhuBStmGMBG0BdeDZS/dZx1IukaX6Bk11zcln25o1Aw==
+
+picomatch@^2.0.4, picomatch@^2.2.1:
+  version "2.3.1"
+  resolved "https://registry.yarnpkg.com/picomatch/-/picomatch-2.3.1.tgz#3ba3833733646d9d3e4995946c1365a67fb07a42"
+  integrity sha512-JU3teHTNjmE2VCGFzuY8EXzCDVwEqB2a8fsIvwaStHhAWJEeVd1o1QD80CU6+ZdEXXSLbSsuLwJjkCBWqRQUVA==
+
+postcss@^8.4.43:
+  version "8.4.44"
+  resolved "https://registry.yarnpkg.com/postcss/-/postcss-8.4.44.tgz#d56834ef6508610ba224bb22b2457b2169ed0480"
+  integrity sha512-Aweb9unOEpQ3ezu4Q00DPvvM2ZTUitJdNKeP/+uQgr1IBIqu574IaZoURId7BKtWMREwzKa9OgzPzezWGPWFQw==
+  dependencies:
+    nanoid "^3.3.7"
+    picocolors "^1.0.1"
+    source-map-js "^1.2.0"
+
+promise@^8.1.0:
+  version "8.3.0"
+  resolved "https://registry.yarnpkg.com/promise/-/promise-8.3.0.tgz#8cb333d1edeb61ef23869fbb8a4ea0279ab60e0a"
+  integrity sha512-rZPNPKTOYVNEEKFaq1HqTgOwZD+4/YHS5ukLzQCypkj+OkYx7iv0mA91lJlpPPZ8vMau3IIGj5Qlwrx+8iiSmg==
+  dependencies:
+    asap "~2.0.6"
+
+prop-types-extra@^1.1.0:
+  version "1.1.1"
+  resolved "https://registry.yarnpkg.com/prop-types-extra/-/prop-types-extra-1.1.1.tgz#58c3b74cbfbb95d304625975aa2f0848329a010b"
+  integrity sha512-59+AHNnHYCdiC+vMwY52WmvP5dM3QLeoumYuEyceQDi9aEhtwN9zIQ2ZNo25sMyXnbh32h+P1ezDsUpUH3JAew==
+  dependencies:
+    react-is "^16.3.2"
+    warning "^4.0.0"
+
+prop-types@^15.6.2, prop-types@^15.7.2:
+  version "15.8.1"
+  resolved "https://registry.yarnpkg.com/prop-types/-/prop-types-15.8.1.tgz#67d87bf1a694f48435cf332c24af10214a3140b5"
+  integrity sha512-oj87CgZICdulUohogVAR7AjlC0327U4el4L6eAvOqCeudMDVU0NThNaV+b9Df4dXgSP1gXMTnPdhfe/2qDH5cg==
+  dependencies:
+    loose-envify "^1.4.0"
+    object-assign "^4.1.1"
+    react-is "^16.13.1"
+
+proxy-from-env@^1.1.0:
+  version "1.1.0"
+  resolved "https://registry.yarnpkg.com/proxy-from-env/-/proxy-from-env-1.1.0.tgz#e102f16ca355424865755d2c9e8ea4f24d58c3e2"
+  integrity sha512-D+zkORCbA9f1tdWRK0RaCR3GPv50cMxcrz4X8k5LTSUD1Dkw47mKJEZQNunItRTkWwgtaUSo1RVFRIG9ZXiFYg==
+
+psl@^1.1.33:
+  version "1.9.0"
+  resolved "https://registry.yarnpkg.com/psl/-/psl-1.9.0.tgz#d0df2a137f00794565fcaf3b2c00cd09f8d5a5a7"
+  integrity sha512-E/ZsdU4HLs/68gYzgGTkMicWTLPdAftJLfJFlLUAAKZGkStNU72sZjT66SnMDVOfOWY/YAoiD7Jxa9iHvngcag==
+
+punycode@^2.1.1, punycode@^2.3.1:
+  version "2.3.1"
+  resolved "https://registry.yarnpkg.com/punycode/-/punycode-2.3.1.tgz#027422e2faec0b25e1549c3e1bd8309b9133b6e5"
+  integrity sha512-vYt7UD1U9Wg6138shLtLOvdAu+8DsC/ilFtEVHcH+wydcSpNE20AfSOduf6MkRFahL5FY7X1oU7nKVZFtfq8Fg==
+
+querystringify@^2.1.1:
+  version "2.2.0"
+  resolved "https://registry.yarnpkg.com/querystringify/-/querystringify-2.2.0.tgz#3345941b4153cb9d082d8eee4cda2016a9aef7f6"
+  integrity sha512-FIqgj2EUvTa7R50u0rGsyTftzjYmv/a3hO345bZNrqabNqjtgiDMgmo4mkUjd+nzU5oF3dClKqFIPUKybUyqoQ==
+
+raf@^3.4.1:
+  version "3.4.1"
+  resolved "https://registry.yarnpkg.com/raf/-/raf-3.4.1.tgz#0742e99a4a6552f445d73e3ee0328af0ff1ede39"
+  integrity sha512-Sq4CW4QhwOHE8ucn6J34MqtZCeWFP2aQSmrlroYgqAV1PjStIhJXxYuTgUIfkEk7zTLjmIjLmU5q+fbD1NnOJA==
+  dependencies:
+    performance-now "^2.1.0"
+
+react-app-polyfill@~3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/react-app-polyfill/-/react-app-polyfill-3.0.0.tgz#95221e0a9bd259e5ca6b177c7bb1cb6768f68fd7"
+  integrity sha512-sZ41cxiU5llIB003yxxQBYrARBqe0repqPTTYBTmMqTz9szeBbE37BehCE891NZsmdZqqP+xWKdT3eo3vOzN8w==
+  dependencies:
+    core-js "^3.19.2"
+    object-assign "^4.1.1"
+    promise "^8.1.0"
+    raf "^3.4.1"
+    regenerator-runtime "^0.13.9"
+    whatwg-fetch "^3.6.2"
+
+react-bootstrap@^1.6.5:
+  version "1.6.8"
+  resolved "https://registry.yarnpkg.com/react-bootstrap/-/react-bootstrap-1.6.8.tgz#e9380d81cdb92c433f61b37a9120b8edd49912a1"
+  integrity sha512-yD6uN78XlFOkETQp6GRuVe0s5509x3XYx8PfPbirwFTYCj5/RfmSs9YZGCwkUrhZNFzj7tZPdpb+3k50mK1E4g==
+  dependencies:
+    "@babel/runtime" "^7.14.0"
+    "@restart/context" "^2.1.4"
+    "@restart/hooks" "^0.4.7"
+    "@types/invariant" "^2.2.33"
+    "@types/prop-types" "^15.7.3"
+    "@types/react" ">=16.14.8"
+    "@types/react-transition-group" "^4.4.1"
+    "@types/warning" "^3.0.0"
+    classnames "^2.3.1"
+    dom-helpers "^5.2.1"
+    invariant "^2.2.4"
+    prop-types "^15.7.2"
+    prop-types-extra "^1.1.0"
+    react-overlays "^5.1.2"
+    react-transition-group "^4.4.1"
+    uncontrollable "^7.2.1"
+    warning "^4.0.3"
+
+react-dom@^18.2.0:
+  version "18.3.1"
+  resolved "https://registry.yarnpkg.com/react-dom/-/react-dom-18.3.1.tgz#c2265d79511b57d479b3dd3fdfa51536494c5cb4"
+  integrity sha512-5m4nQKp+rZRb09LNH59GM4BxTh9251/ylbKIbpe7TpGxfJ+9kv6BLkLBXIjjspbgbnIBNqlI23tRnTWT0snUIw==
+  dependencies:
+    loose-envify "^1.1.0"
+    scheduler "^0.23.2"
+
+react-icons@^5.3.0:
+  version "5.3.0"
+  resolved "https://registry.yarnpkg.com/react-icons/-/react-icons-5.3.0.tgz#ccad07a30aebd40a89f8cfa7d82e466019203f1c"
+  integrity sha512-DnUk8aFbTyQPSkCfF8dbX6kQjXA9DktMeJqfjrg6cK9vwQVMxmcA3BfP4QoiztVmEHtwlTgLFsPuH2NskKT6eg==
+
+react-is@^16.13.1, react-is@^16.3.2:
+  version "16.13.1"
+  resolved "https://registry.yarnpkg.com/react-is/-/react-is-16.13.1.tgz#789729a4dc36de2999dc156dd6c1d9c18cea56a4"
+  integrity sha512-24e6ynE2H+OKt4kqsOvNd8kBpV65zoxbA4BVsEOB3ARVWQki/DHzaUoC5KuON/BiccDaCCTZBuOcfZs70kR8bQ==
+
+react-lifecycles-compat@^3.0.4:
+  version "3.0.4"
+  resolved "https://registry.yarnpkg.com/react-lifecycles-compat/-/react-lifecycles-compat-3.0.4.tgz#4f1a273afdfc8f3488a8c516bfda78f872352362"
+  integrity sha512-fBASbA6LnOU9dOU2eW7aQ8xmYBSXUIWr+UmF9b1efZBazGNO+rcXT/icdKnYm2pTwcRylVUYwW7H1PHfLekVzA==
+
+react-overlays@^5.1.2:
+  version "5.2.1"
+  resolved "https://registry.yarnpkg.com/react-overlays/-/react-overlays-5.2.1.tgz#49dc007321adb6784e1f212403f0fb37a74ab86b"
+  integrity sha512-GLLSOLWr21CqtJn8geSwQfoJufdt3mfdsnIiQswouuQ2MMPns+ihZklxvsTDKD3cR2tF8ELbi5xUsvqVhR6WvA==
+  dependencies:
+    "@babel/runtime" "^7.13.8"
+    "@popperjs/core" "^2.11.6"
+    "@restart/hooks" "^0.4.7"
+    "@types/warning" "^3.0.0"
+    dom-helpers "^5.2.0"
+    prop-types "^15.7.2"
+    uncontrollable "^7.2.1"
+    warning "^4.0.3"
+
+react-refresh@^0.14.2:
+  version "0.14.2"
+  resolved "https://registry.yarnpkg.com/react-refresh/-/react-refresh-0.14.2.tgz#3833da01ce32da470f1f936b9d477da5c7028bf9"
+  integrity sha512-jCvmsr+1IUSMUyzOkRcvnVbX3ZYC6g9TDrDbFuFmRDq7PD4yaGbLKNQL6k2jnArV8hjYxh7hVhAZB6s9HDGpZA==
+
+react-router-dom@^6.3.0:
+  version "6.26.1"
+  resolved "https://registry.yarnpkg.com/react-router-dom/-/react-router-dom-6.26.1.tgz#a408892b41767a49dc94b3564b0e7d8e3959f623"
+  integrity sha512-veut7m41S1fLql4pLhxeSW3jlqs+4MtjRLj0xvuCEXsxusJCbs6I8yn9BxzzDX2XDgafrccY6hwjmd/bL54tFw==
+  dependencies:
+    "@remix-run/router" "1.19.1"
+    react-router "6.26.1"
+
+react-router@6.26.1:
+  version "6.26.1"
+  resolved "https://registry.yarnpkg.com/react-router/-/react-router-6.26.1.tgz#88c64837e05ffab6899a49df2a1484a22471e4ce"
+  integrity sha512-kIwJveZNwp7teQRI5QmwWo39A5bXRyqpH0COKKmPnyD2vBvDwgFXSqDUYtt1h+FEyfnE8eXr7oe0MxRzVwCcvQ==
+  dependencies:
+    "@remix-run/router" "1.19.1"
+
+react-transition-group@^4.4.1:
+  version "4.4.5"
+  resolved "https://registry.yarnpkg.com/react-transition-group/-/react-transition-group-4.4.5.tgz#e53d4e3f3344da8521489fbef8f2581d42becdd1"
+  integrity sha512-pZcd1MCJoiKiBR2NRxeCRg13uCXbydPnmB4EOeRrY7480qNWO8IIgQG6zlDkm6uRMsURXPuKq0GWtiM59a5Q6g==
+  dependencies:
+    "@babel/runtime" "^7.5.5"
+    dom-helpers "^5.0.1"
+    loose-envify "^1.4.0"
+    prop-types "^15.6.2"
+
+react@^18.2.0:
+  version "18.3.1"
+  resolved "https://registry.yarnpkg.com/react/-/react-18.3.1.tgz#49ab892009c53933625bd16b2533fc754cab2891"
+  integrity sha512-wS+hAgJShR0KhEvPJArfuPVN1+Hz1t0Y6n5jLrGQbkb4urgPE/0Rve+1kMB1v/oWgHgm4WIcV+i7F2pTVj+2iQ==
+  dependencies:
+    loose-envify "^1.1.0"
+
+readdirp@~3.6.0:
+  version "3.6.0"
+  resolved "https://registry.yarnpkg.com/readdirp/-/readdirp-3.6.0.tgz#74a370bd857116e245b29cc97340cd431a02a6c7"
+  integrity sha512-hOS089on8RduqdbhvQ5Z37A0ESjsqz6qnRcffsMU3495FuTdqSm+7bhJ29JvIOsBDEEnan5DPu9t3To9VRlMzA==
+  dependencies:
+    picomatch "^2.2.1"
+
+regenerator-runtime@^0.13.9:
+  version "0.13.11"
+  resolved "https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.13.11.tgz#f6dca3e7ceec20590d07ada785636a90cdca17f9"
+  integrity sha512-kY1AZVr2Ra+t+piVaJ4gxaFaReZVH40AKNo7UCX6W+dEwBo/2oZJzqfuN1qLq1oL45o56cPaTXELwrTh8Fpggg==
+
+regenerator-runtime@^0.14.0:
+  version "0.14.1"
+  resolved "https://registry.yarnpkg.com/regenerator-runtime/-/regenerator-runtime-0.14.1.tgz#356ade10263f685dda125100cd862c1db895327f"
+  integrity sha512-dYnhHh0nJoMfnkZs6GmmhFknAGRrLznOu5nc9ML+EJxGvrx6H7teuevqVqCuPcPK//3eDrrjQhehXVx9cnkGdw==
+
+requires-port@^1.0.0:
+  version "1.0.0"
+  resolved "https://registry.yarnpkg.com/requires-port/-/requires-port-1.0.0.tgz#925d2601d39ac485e091cf0da5c6e694dc3dcaff"
+  integrity sha512-KigOCHcocU3XODJxsu8i/j8T9tzT4adHiecwORRQ0ZZFcp7ahwXuRU1m+yuO90C5ZUyGeGfocHDI14M3L3yDAQ==
+
+rollup@^4.20.0:
+  version "4.22.4"
+  resolved "https://registry.yarnpkg.com/rollup/-/rollup-4.22.4.tgz#4135a6446671cd2a2453e1ad42a45d5973ec3a0f"
+  integrity sha512-vD8HJ5raRcWOyymsR6Z3o6+RzfEPCnVLMFJ6vRslO1jt4LO6dUo5Qnpg7y4RkZFM2DMe3WUirkI5c16onjrc6A==
+  dependencies:
+    "@types/estree" "1.0.5"
+  optionalDependencies:
+    "@rollup/rollup-android-arm-eabi" "4.22.4"
+    "@rollup/rollup-android-arm64" "4.22.4"
+    "@rollup/rollup-darwin-arm64" "4.22.4"
+    "@rollup/rollup-darwin-x64" "4.22.4"
+    "@rollup/rollup-linux-arm-gnueabihf" "4.22.4"
+    "@rollup/rollup-linux-arm-musleabihf" "4.22.4"
+    "@rollup/rollup-linux-arm64-gnu" "4.22.4"
+    "@rollup/rollup-linux-arm64-musl" "4.22.4"
+    "@rollup/rollup-linux-powerpc64le-gnu" "4.22.4"
+    "@rollup/rollup-linux-riscv64-gnu" "4.22.4"
+    "@rollup/rollup-linux-s390x-gnu" "4.22.4"
+    "@rollup/rollup-linux-x64-gnu" "4.22.4"
+    "@rollup/rollup-linux-x64-musl" "4.22.4"
+    "@rollup/rollup-win32-arm64-msvc" "4.22.4"
+    "@rollup/rollup-win32-ia32-msvc" "4.22.4"
+    "@rollup/rollup-win32-x64-msvc" "4.22.4"
+    fsevents "~2.3.2"
+
+rrweb-cssom@^0.6.0:
+  version "0.6.0"
+  resolved "https://registry.yarnpkg.com/rrweb-cssom/-/rrweb-cssom-0.6.0.tgz#ed298055b97cbddcdeb278f904857629dec5e0e1"
+  integrity sha512-APM0Gt1KoXBz0iIkkdB/kfvGOwC4UuJFeG/c+yV7wSc7q96cG/kJ0HiYCnzivD9SB53cLV1MlHFNfOuPaadYSw==
+
+rrweb-cssom@^0.7.1:
+  version "0.7.1"
+  resolved "https://registry.yarnpkg.com/rrweb-cssom/-/rrweb-cssom-0.7.1.tgz#c73451a484b86dd7cfb1e0b2898df4b703183e4b"
+  integrity sha512-TrEMa7JGdVm0UThDJSx7ddw5nVm3UJS9o9CCIZ72B1vSyEZoziDqBYP3XIoi/12lKrJR8rE3jeFHMok2F/Mnsg==
+
+"safer-buffer@>= 2.1.2 < 3.0.0":
+  version "2.1.2"
+  resolved "https://registry.yarnpkg.com/safer-buffer/-/safer-buffer-2.1.2.tgz#44fa161b0187b9549dd84bb91802f9bd8385cd6a"
+  integrity sha512-YZo3K82SD7Riyi0E1EQPojLz7kpepnSQI9IyPbHHg1XXXevb5dJI7tpyN2ADxGcQbHG7vcyRHk0cbwqcQriUtg==
+
+sass@^1.56.0:
+  version "1.77.8"
+  resolved "https://registry.yarnpkg.com/sass/-/sass-1.77.8.tgz#9f18b449ea401759ef7ec1752a16373e296b52bd"
+  integrity sha512-4UHg6prsrycW20fqLGPShtEvo/WyHRVRHwOP4DzkUrObWoWI05QBSfzU71TVB7PFaL104TwNaHpjlWXAZbQiNQ==
+  dependencies:
+    chokidar ">=3.0.0 <4.0.0"
+    immutable "^4.0.0"
+    source-map-js ">=0.6.2 <2.0.0"
+
+saxes@^6.0.0:
+  version "6.0.0"
+  resolved "https://registry.yarnpkg.com/saxes/-/saxes-6.0.0.tgz#fe5b4a4768df4f14a201b1ba6a65c1f3d9988cc5"
+  integrity sha512-xAg7SOnEhrm5zI3puOOKyy1OMcMlIJZYNJY7xLBwSze0UjhPLnWfj2GF2EpT0jmzaJKIWKHLsaSSajf35bcYnA==
+  dependencies:
+    xmlchars "^2.2.0"
+
+scheduler@^0.23.2:
+  version "0.23.2"
+  resolved "https://registry.yarnpkg.com/scheduler/-/scheduler-0.23.2.tgz#414ba64a3b282892e944cf2108ecc078d115cdc3"
+  integrity sha512-UOShsPwz7NrMUqhR6t0hWjFduvOzbtv7toDH1/hIrfRNIDBnnBWd0CwJTGvTpngVlmwGCdP9/Zl/tVrDqcuYzQ==
+  dependencies:
+    loose-envify "^1.1.0"
+
+semver@^6.3.1:
+  version "6.3.1"
+  resolved "https://registry.yarnpkg.com/semver/-/semver-6.3.1.tgz#556d2ef8689146e46dcea4bfdd095f3434dffcb4"
+  integrity sha512-BR7VvDCVHO+q2xBEWskxS6DJE1qRnb7DxzUrogb71CWoSficBxYsiAGd+Kl0mmq/MprG9yArRkyrQxTO6XjMzA==
+
+shebang-command@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/shebang-command/-/shebang-command-2.0.0.tgz#ccd0af4f8835fbdc265b82461aaf0c36663f34ea"
+  integrity sha512-kHxr2zZpYtdmrN1qDjrrX/Z1rR1kG8Dx+gkpK1G4eXmvXswmcE1hTWBWYUzlraYw1/yZp6YuDY77YtvbN0dmDA==
+  dependencies:
+    shebang-regex "^3.0.0"
+
+shebang-regex@^3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/shebang-regex/-/shebang-regex-3.0.0.tgz#ae16f1644d873ecad843b0307b143362d4c42172"
+  integrity sha512-7++dFhtcx3353uBaq8DDR4NuxBetBzC7ZQOhmTQInHEd6bSrXdiEyzCvG07Z44UYdLShWUyXt5M/yhz8ekcb1A==
+
+siginfo@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/siginfo/-/siginfo-2.0.0.tgz#32e76c70b79724e3bb567cb9d543eb858ccfaf30"
+  integrity sha512-ybx0WO1/8bSBLEWXZvEd7gMW3Sn3JFlW3TvX1nREbDLRNQNaeNN8WK0meBwPdAaOI7TtRRRJn/Es1zhrrCHu7g==
+
+signal-exit@^4.1.0:
+  version "4.1.0"
+  resolved "https://registry.yarnpkg.com/signal-exit/-/signal-exit-4.1.0.tgz#952188c1cbd546070e2dd20d0f41c0ae0530cb04"
+  integrity sha512-bzyZ1e88w9O1iNJbKnOlvYTrWPDl46O1bG0D3XInv+9tkPrxrN8jUUTiFlDkkmKWgn1M6CfIA13SuGqOa9Korw==
+
+"source-map-js@>=0.6.2 <2.0.0", source-map-js@^1.2.0:
+  version "1.2.0"
+  resolved "https://registry.yarnpkg.com/source-map-js/-/source-map-js-1.2.0.tgz#16b809c162517b5b8c3e7dcd315a2a5c2612b2af"
+  integrity sha512-itJW8lvSA0TXEphiRoawsCksnlf8SyvmFzIhltqAHluXd88pkCd+cXJVHTDwdCr0IzwptSm035IHQktUu1QUMg==
+
+stackback@0.0.2:
+  version "0.0.2"
+  resolved "https://registry.yarnpkg.com/stackback/-/stackback-0.0.2.tgz#1ac8a0d9483848d1695e418b6d031a3c3ce68e3b"
+  integrity sha512-1XMJE5fQo1jGH6Y/7ebnwPOBEkIEnT4QF32d5R1+VXdXveM0IBMJt8zfaxX1P3QhVwrYe+576+jkANtSS2mBbw==
+
+std-env@^3.7.0:
+  version "3.7.0"
+  resolved "https://registry.yarnpkg.com/std-env/-/std-env-3.7.0.tgz#c9f7386ced6ecf13360b6c6c55b8aaa4ef7481d2"
+  integrity sha512-JPbdCEQLj1w5GilpiHAx3qJvFndqybBysA3qUOnznweH4QbNYUsW/ea8QzSrnh0vNsezMMw5bcVool8lM0gwzg==
+
+strip-final-newline@^3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/strip-final-newline/-/strip-final-newline-3.0.0.tgz#52894c313fbff318835280aed60ff71ebf12b8fd"
+  integrity sha512-dOESqjYr96iWYylGObzd39EuNTa5VJxyvVAEm5Jnh7KGo75V43Hk1odPQkNDyXNmUR6k+gEiDVXnjB8HJ3crXw==
+
+supports-color@^5.3.0:
+  version "5.5.0"
+  resolved "https://registry.yarnpkg.com/supports-color/-/supports-color-5.5.0.tgz#e2e69a44ac8772f78a1ec0b35b689df6530efc8f"
+  integrity sha512-QjVjwdXIt408MIiAqCX4oUKsgU2EqAGzs2Ppkm4aQYbjm+ZEWEcW4SfFNTr4uMNZma0ey4f5lgLrkB0aX0QMow==
+  dependencies:
+    has-flag "^3.0.0"
+
+symbol-tree@^3.2.4:
+  version "3.2.4"
+  resolved "https://registry.yarnpkg.com/symbol-tree/-/symbol-tree-3.2.4.tgz#430637d248ba77e078883951fb9aa0eed7c63fa2"
+  integrity sha512-9QNk5KwDF+Bvz+PyObkmSYjI5ksVUYtjW7AU22r2NKcfLJcXp96hkDWU3+XndOsUb+AQ9QhfzfCT2O+CNWT5Tw==
+
+tinybench@^2.8.0:
+  version "2.9.0"
+  resolved "https://registry.yarnpkg.com/tinybench/-/tinybench-2.9.0.tgz#103c9f8ba6d7237a47ab6dd1dcff77251863426b"
+  integrity sha512-0+DUvqWMValLmha6lr4kD8iAMK1HzV0/aKnCtWb9v9641TnP/MFb7Pc2bxoxQjTXAErryXVgUOfv2YqNllqGeg==
+
+tinypool@^1.0.0:
+  version "1.0.1"
+  resolved "https://registry.yarnpkg.com/tinypool/-/tinypool-1.0.1.tgz#c64233c4fac4304e109a64340178760116dbe1fe"
+  integrity sha512-URZYihUbRPcGv95En+sz6MfghfIc2OJ1sv/RmhWZLouPY0/8Vo80viwPvg3dlaS9fuq7fQMEfgRRK7BBZThBEA==
+
+tinyrainbow@^1.2.0:
+  version "1.2.0"
+  resolved "https://registry.yarnpkg.com/tinyrainbow/-/tinyrainbow-1.2.0.tgz#5c57d2fc0fb3d1afd78465c33ca885d04f02abb5"
+  integrity sha512-weEDEq7Z5eTHPDh4xjX789+fHfF+P8boiFB+0vbWzpbnbsEr/GRaohi/uMKxg8RZMXnl1ItAi/IUHWMsjDV7kQ==
+
+tinyspy@^3.0.0:
+  version "3.0.0"
+  resolved "https://registry.yarnpkg.com/tinyspy/-/tinyspy-3.0.0.tgz#cb61644f2713cd84dee184863f4642e06ddf0585"
+  integrity sha512-q5nmENpTHgiPVd1cJDDc9cVoYN5x4vCvwT3FMilvKPKneCBZAxn2YWQjDF0UMcE9k0Cay1gBiDfTMU0g+mPMQA==
+
+to-fast-properties@^2.0.0:
+  version "2.0.0"
+  resolved "https://registry.yarnpkg.com/to-fast-properties/-/to-fast-properties-2.0.0.tgz#dc5e698cbd079265bc73e0377681a4e4e83f616e"
+  integrity sha512-/OaKK0xYrs3DmxRYqL/yDc+FxFUVYhDlXMhRmv3z915w2HF1tnN1omB354j8VUGO/hbRzyD6Y3sA7v7GS/ceog==
+
+to-regex-range@^5.0.1:
+  version "5.0.1"
+  resolved "https://registry.yarnpkg.com/to-regex-range/-/to-regex-range-5.0.1.tgz#1648c44aae7c8d988a326018ed72f5b4dd0392e4"
+  integrity sha512-65P7iz6X5yEr1cwcgvQxbbIw7Uk3gOy5dIdtZ4rDveLqhrdJP+Li/Hx6tyK0NEb+2GCyneCMJiGqrADCSNk8sQ==
+  dependencies:
+    is-number "^7.0.0"
+
+tough-cookie@^4.1.4:
+  version "4.1.4"
+  resolved "https://registry.yarnpkg.com/tough-cookie/-/tough-cookie-4.1.4.tgz#945f1461b45b5a8c76821c33ea49c3ac192c1b36"
+  integrity sha512-Loo5UUvLD9ScZ6jh8beX1T6sO1w2/MpCRpEP7V280GKMVUQ0Jzar2U3UJPsrdbziLEMMhu3Ujnq//rhiFuIeag==
+  dependencies:
+    psl "^1.1.33"
+    punycode "^2.1.1"
+    universalify "^0.2.0"
+    url-parse "^1.5.3"
+
+tr46@^5.0.0:
+  version "5.0.0"
+  resolved "https://registry.yarnpkg.com/tr46/-/tr46-5.0.0.tgz#3b46d583613ec7283020d79019f1335723801cec"
+  integrity sha512-tk2G5R2KRwBd+ZN0zaEXpmzdKyOYksXwywulIX95MBODjSzMIuQnQ3m8JxgbhnL1LeVo7lqQKsYa1O3Htl7K5g==
+  dependencies:
+    punycode "^2.3.1"
+
+uncontrollable@^7.2.1:
+  version "7.2.1"
+  resolved "https://registry.yarnpkg.com/uncontrollable/-/uncontrollable-7.2.1.tgz#1fa70ba0c57a14d5f78905d533cf63916dc75738"
+  integrity sha512-svtcfoTADIB0nT9nltgjujTi7BzVmwjZClOmskKu/E8FW9BXzg9os8OLr4f8Dlnk0rYWJIWr4wv9eKUXiQvQwQ==
+  dependencies:
+    "@babel/runtime" "^7.6.3"
+    "@types/react" ">=16.9.11"
+    invariant "^2.2.4"
+    react-lifecycles-compat "^3.0.4"
+
+universalify@^0.2.0:
+  version "0.2.0"
+  resolved "https://registry.yarnpkg.com/universalify/-/universalify-0.2.0.tgz#6451760566fa857534745ab1dde952d1b1761be0"
+  integrity sha512-CJ1QgKmNg3CwvAv/kOFmtnEN05f0D/cn9QntgNOQlQF9dgvVTHj3t+8JPdjqawCHk7V/KA+fbUqzZ9XWhcqPUg==
+
+update-browserslist-db@^1.1.0:
+  version "1.1.0"
+  resolved "https://registry.yarnpkg.com/update-browserslist-db/-/update-browserslist-db-1.1.0.tgz#7ca61c0d8650766090728046e416a8cde682859e"
+  integrity sha512-EdRAaAyk2cUE1wOf2DkEhzxqOQvFOoRJFNS6NeyJ01Gp2beMRpBAINjM2iDXE3KCuKhwnvHIQCJm6ThL2Z+HzQ==
+  dependencies:
+    escalade "^3.1.2"
+    picocolors "^1.0.1"
+
+url-parse@^1.5.3:
+  version "1.5.10"
+  resolved "https://registry.yarnpkg.com/url-parse/-/url-parse-1.5.10.tgz#9d3c2f736c1d75dd3bd2be507dcc111f1e2ea9c1"
+  integrity sha512-WypcfiRhfeUP9vvF0j6rw0J3hrWrw6iZv3+22h6iRMJ/8z1Tj6XfLP4DsUix5MhMPnXpiHDoKyoZ/bdCkwBCiQ==
+  dependencies:
+    querystringify "^2.1.1"
+    requires-port "^1.0.0"
+
+use-sync-external-store@^1.2.0:
+  version "1.2.2"
+  resolved "https://registry.yarnpkg.com/use-sync-external-store/-/use-sync-external-store-1.2.2.tgz#c3b6390f3a30eba13200d2302dcdf1e7b57b2ef9"
+  integrity sha512-PElTlVMwpblvbNqQ82d2n6RjStvdSoNe9FG28kNfz3WiXilJm4DdNkEzRhCZuIDwY8U08WVihhGR5iRqAwfDiw==
+
+vite-node@2.0.5:
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/vite-node/-/vite-node-2.0.5.tgz#36d909188fc6e3aba3da5fc095b3637d0d18e27b"
+  integrity sha512-LdsW4pxj0Ot69FAoXZ1yTnA9bjGohr2yNBU7QKRxpz8ITSkhuDl6h3zS/tvgz4qrNjeRnvrWeXQ8ZF7Um4W00Q==
+  dependencies:
+    cac "^6.7.14"
+    debug "^4.3.5"
+    pathe "^1.1.2"
+    tinyrainbow "^1.2.0"
+    vite "^5.0.0"
+
+vite@^5.0.0, vite@~5.4.3:
+  version "5.4.3"
+  resolved "https://registry.yarnpkg.com/vite/-/vite-5.4.3.tgz#771c470e808cb6732f204e1ee96c2ed65b97a0eb"
+  integrity sha512-IH+nl64eq9lJjFqU+/yrRnrHPVTlgy42/+IzbOdaFDVlyLgI/wDlf+FCobXLX1cT0X5+7LMyH1mIy2xJdLfo8Q==
+  dependencies:
+    esbuild "^0.21.3"
+    postcss "^8.4.43"
+    rollup "^4.20.0"
+  optionalDependencies:
+    fsevents "~2.3.3"
+
+vitest@~2.0.5:
+  version "2.0.5"
+  resolved "https://registry.yarnpkg.com/vitest/-/vitest-2.0.5.tgz#2f15a532704a7181528e399cc5b754c7f335fd62"
+  integrity sha512-8GUxONfauuIdeSl5f9GTgVEpg5BTOlplET4WEDaeY2QBiN8wSm68vxN/tb5z405OwppfoCavnwXafiaYBC/xOA==
+  dependencies:
+    "@ampproject/remapping" "^2.3.0"
+    "@vitest/expect" "2.0.5"
+    "@vitest/pretty-format" "^2.0.5"
+    "@vitest/runner" "2.0.5"
+    "@vitest/snapshot" "2.0.5"
+    "@vitest/spy" "2.0.5"
+    "@vitest/utils" "2.0.5"
+    chai "^5.1.1"
+    debug "^4.3.5"
+    execa "^8.0.1"
+    magic-string "^0.30.10"
+    pathe "^1.1.2"
+    std-env "^3.7.0"
+    tinybench "^2.8.0"
+    tinypool "^1.0.0"
+    tinyrainbow "^1.2.0"
+    vite "^5.0.0"
+    vite-node "2.0.5"
+    why-is-node-running "^2.3.0"
+
+w3c-xmlserializer@^5.0.0:
+  version "5.0.0"
+  resolved "https://registry.yarnpkg.com/w3c-xmlserializer/-/w3c-xmlserializer-5.0.0.tgz#f925ba26855158594d907313cedd1476c5967f6c"
+  integrity sha512-o8qghlI8NZHU1lLPrpi2+Uq7abh4GGPpYANlalzWxyWteJOCsr/P+oPBA49TOLu5FTZO4d3F9MnWJfiMo4BkmA==
+  dependencies:
+    xml-name-validator "^5.0.0"
+
+warning@^4.0.0, warning@^4.0.3:
+  version "4.0.3"
+  resolved "https://registry.yarnpkg.com/warning/-/warning-4.0.3.tgz#16e9e077eb8a86d6af7d64aa1e05fd85b4678ca3"
+  integrity sha512-rpJyN222KWIvHJ/F53XSZv0Zl/accqHR8et1kpaMTD/fLCRxtV8iX8czMzY7sVZupTI3zcUTg8eycS2kNF9l6w==
+  dependencies:
+    loose-envify "^1.0.0"
+
+webidl-conversions@^7.0.0:
+  version "7.0.0"
+  resolved "https://registry.yarnpkg.com/webidl-conversions/-/webidl-conversions-7.0.0.tgz#256b4e1882be7debbf01d05f0aa2039778ea080a"
+  integrity sha512-VwddBukDzu71offAQR975unBIGqfKZpM+8ZX6ySk8nYhVoo5CYaZyzt3YBvYtRtO+aoGlqxPg/B87NGVZ/fu6g==
+
+whatwg-encoding@^3.1.1:
+  version "3.1.1"
+  resolved "https://registry.yarnpkg.com/whatwg-encoding/-/whatwg-encoding-3.1.1.tgz#d0f4ef769905d426e1688f3e34381a99b60b76e5"
+  integrity sha512-6qN4hJdMwfYBtE3YBTTHhoeuUrDBPZmbQaxWAqSALV/MeEnR5z1xd8UKud2RAkFoPkmB+hli1TZSnyi84xz1vQ==
+  dependencies:
+    iconv-lite "0.6.3"
+
+whatwg-fetch@^3.6.2:
+  version "3.6.20"
+  resolved "https://registry.yarnpkg.com/whatwg-fetch/-/whatwg-fetch-3.6.20.tgz#580ce6d791facec91d37c72890995a0b48d31c70"
+  integrity sha512-EqhiFU6daOA8kpjOWTL0olhVOF3i7OrFzSYiGsEMB8GcXS+RrzauAERX65xMeNWVqxA6HXH2m69Z9LaKKdisfg==
+
+whatwg-mimetype@^4.0.0:
+  version "4.0.0"
+  resolved "https://registry.yarnpkg.com/whatwg-mimetype/-/whatwg-mimetype-4.0.0.tgz#bc1bf94a985dc50388d54a9258ac405c3ca2fc0a"
+  integrity sha512-QaKxh0eNIi2mE9p2vEdzfagOKHCcj1pJ56EEHGQOVxp8r9/iszLUUV7v89x9O1p/T+NlTM5W7jW6+cz4Fq1YVg==
+
+whatwg-url@^14.0.0:
+  version "14.0.0"
+  resolved "https://registry.yarnpkg.com/whatwg-url/-/whatwg-url-14.0.0.tgz#00baaa7fd198744910c4b1ef68378f2200e4ceb6"
+  integrity sha512-1lfMEm2IEr7RIV+f4lUNPOqfFL+pO+Xw3fJSqmjX9AbXcXcYOkCe1P6+9VBZB6n94af16NfZf+sSk0JCBZC9aw==
+  dependencies:
+    tr46 "^5.0.0"
+    webidl-conversions "^7.0.0"
+
+which@^2.0.1:
+  version "2.0.2"
+  resolved "https://registry.yarnpkg.com/which/-/which-2.0.2.tgz#7c6a8dd0a636a0327e10b59c9286eee93f3f51b1"
+  integrity sha512-BLI3Tl1TW3Pvl70l3yq3Y64i+awpwXqsGBYWkkqMtnbXgrMD+yj7rhW0kuEDxzJaYXGjEW5ogapKNMEKNMjibA==
+  dependencies:
+    isexe "^2.0.0"
+
+why-is-node-running@^2.3.0:
+  version "2.3.0"
+  resolved "https://registry.yarnpkg.com/why-is-node-running/-/why-is-node-running-2.3.0.tgz#a3f69a97107f494b3cdc3bdddd883a7d65cebf04"
+  integrity sha512-hUrmaWBdVDcxvYqnyh09zunKzROWjbZTiNy8dBEjkS7ehEDQibXJ7XvlmtbwuTclUiIyN+CyXQD4Vmko8fNm8w==
+  dependencies:
+    siginfo "^2.0.0"
+    stackback "0.0.2"
+
+ws@^8.18.0:
+  version "8.18.0"
+  resolved "https://registry.yarnpkg.com/ws/-/ws-8.18.0.tgz#0d7505a6eafe2b0e712d232b42279f53bc289bbc"
+  integrity sha512-8VbfWfHLbbwu3+N6OKsOMpBdT4kXPDDB9cJk2bJ6mh9ucxdlnNvH1e+roYkKmN9Nxw2yjz7VzeO9oOz2zJ04Pw==
+
+xml-name-validator@^5.0.0:
+  version "5.0.0"
+  resolved "https://registry.yarnpkg.com/xml-name-validator/-/xml-name-validator-5.0.0.tgz#82be9b957f7afdacf961e5980f1bf227c0bf7673"
+  integrity sha512-EvGK8EJ3DhaHfbRlETOWAS5pO9MZITeauHKJyb8wyajUfQUenkIg2MvLDTZ4T/TgIcm3HU0TFBgWWboAZ30UHg==
+
+xmlchars@^2.2.0:
+  version "2.2.0"
+  resolved "https://registry.yarnpkg.com/xmlchars/-/xmlchars-2.2.0.tgz#060fe1bcb7f9c76fe2a17db86a9bc3ab894210cb"
+  integrity sha512-JZnDKK8B0RCDw84FNdDAIpZK+JuJw+s7Lz8nksI7SIuU3UXJJslUthsi+uWBUYOwPFwW7W7PRLRfUKpxjtjFCw==
+
+yallist@^3.0.2:
+  version "3.1.1"
+  resolved "https://registry.yarnpkg.com/yallist/-/yallist-3.1.1.tgz#dbb7daf9bfd8bac9ab45ebf602b8cbad0d5d08fd"
+  integrity sha512-a4UGQaWPH59mOXUYnAG2ewncQS4i4F43Tv3JoAM+s2VDAmS9NsK8GpDMLrCHPksFT7h3K6TOoUNn2pb7RoXx4g==
diff --git a/yocto_console_view/yocto_console_view/VERSION b/yocto_console_view/yocto_console_view/VERSION
deleted file mode 100644
index 66389d771dcb..000000000000
--- a/yocto_console_view/yocto_console_view/VERSION
+++ /dev/null
@@ -1 +0,0 @@
-1.1.3.dev66
\ No newline at end of file
diff --git a/yocto_console_view/yocto_console_view/static/scripts.js b/yocto_console_view/yocto_console_view/static/scripts.js
deleted file mode 100644
index 238241daf2d1..000000000000
--- a/yocto_console_view/yocto_console_view/static/scripts.js
+++ /dev/null
@@ -1,2 +0,0 @@
-!function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t(require("angular-animate"),require("@uirouter/angularjs"),require("guanlecoja-ui"),require("buildbot-data-js")):"function"==typeof define&&define.amd?define("yocto-console-view",["angular-animate","@uirouter/angularjs","guanlecoja-ui","buildbot-data-js"],t):"object"==typeof exports?exports["yocto-console-view"]=t(require("angular-animate"),require("@uirouter/angularjs"),require("guanlecoja-ui"),require("buildbot-data-js")):e["yocto-console-view"]=t(e["angular-animate"],e["@uirouter/angularjs"],e["guanlecoja-ui"],e["buildbot-data-js"])}("undefined"!=typeof self?self:this,(function(e,t,i,s){return function(e){var t={};function i(s){if(t[s])return t[s].exports;var l=t[s]={i:s,l:!1,exports:{}};return e[s].call(l.exports,l,l.exports,i),l.l=!0,l.exports}return i.m=e,i.c=t,i.d=function(e,t,s){i.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:s})},i.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStrin
 gTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},i.t=function(e,t){if(1&t&&(e=i(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var s=Object.create(null);if(i.r(s),Object.defineProperty(s,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var l in e)i.d(s,l,function(t){return e[t]}.bind(null,l));return s},i.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return i.d(t,"a",t),t},i.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},i.p="",i(i.s=0)}([function(e,t,i){"use strict";i.r(t);i(1),i(2),i(3),i(4);angular.module("yocto_console_view",["ui.router","ui.bootstrap","ngAnimate","guanlecoja.ui","bbData"]).config(["$stateProvider","glMenuServiceProvider","bbSettingsServiceProvider",class ConsoleState{constructor(e,t,s){var l="console";t.addGroup({name:l,caption:"Yocto Console View",icon:"exclamation-circle",order:5});var n={group:l,ca
 ption:"Yocto Console View"},r={controller:"".concat(l,"Controller"),controllerAs:"c",template:i(5),name:l,url:"/".concat(l),data:n};e.state(r),s.addSettingsGroup({name:"Console",caption:"Console related settings",items:[{type:"integer",name:"buildLimit",caption:"Number of builds to fetch",default_value:200},{type:"integer",name:"changeLimit",caption:"Number of changes to fetch",default_value:30}]})}}]).controller("consoleController",["$scope","$q","$window","dataService","bbSettingsService","resultsService","$uibModal","$timeout",class Console{constructor(e,t,i,s,l,n,r,a){this.onChange=this.onChange.bind(this),this._onChange=this._onChange.bind(this),this.matchBuildWithChange=this.matchBuildWithChange.bind(this),this.makeFakeChange=this.makeFakeChange.bind(this),this.$scope=e,this.$window=i,this.$uibModal=r,this.$timeout=a,angular.extend(this,n);var o=l.getSettingsGroup("Console");if(this.buildLimit=o.buildLimit.value,this.changeLimit=o.changeLimit.value,this.dataAccessor=s.open().c
 loseOnDestroy(this.$scope),this._infoIsExpanded={},this.$scope.all_builders=this.all_builders=this.dataAccessor.getBuilders(),this.$scope.builders=this.builders=[],this.$scope.buildergroups=this.buildergroups=[],"undefined"!=typeof Intl&&null!==Intl){var d=new Intl.Collator(void 0,{numeric:!0,sensitivity:"base"});this.strcompare=d.compare}else this.strcompare=function(e,t){return e<t?-1:e===t?0:1};this.$scope.revmapping=this.revmapping={},this.$scope.branchmapping=this.branchmapping={},this.$scope.builds=this.builds=this.dataAccessor.getBuilds({property:["yp_build_revision","yp_build_branch","reason","publish_destination"],limit:this.buildLimit,order:"-started_at"}),this.changes=this.dataAccessor.getChanges({limit:this.changeLimit,order:"-changeid"}),this.$scope.fakechanges=this.fakechanges=[],this.buildrequests=this.dataAccessor.getBuildrequests({limit:this.buildLimit,order:"-submitted_at"}),this.buildsets=this.dataAccessor.getBuildsets({limit:this.buildLimit,order:"-submitted_at"}
 ),this.builds.onChange=this.onChange,this.changes.onChange=this.onChange,this.buildrequests.onChange=this.onChange,this.buildsets.onChange=this.onChange,this.builds.onNew=e=>{var t=!1,i=e.buildid;null!=(null!=e.properties?e.properties.yp_build_revision:void 0)&&(this.revmapping[e.buildid]=e.properties.yp_build_revision[0],t=!0),null!=(null!=e.properties?e.properties.yp_build_branch:void 0)&&(this.branchmapping[e.buildid]=e.properties.yp_build_branch[0],t=!0),this.revmapping[i]&&this.branchmapping[i]||e.complete_at||(e.getProperties().onChange=e=>{if(t=!1,i=e.endpoint.split("/")[1],!this.revmapping[i]){var s=this.getBuildProperty(e[0],"yp_build_revision");null!=s&&(this.revmapping[i]=s,t=!0)}if(!this.branchmapping[i]){var l=this.getBuildProperty(e[0],"yp_build_branch");null!=l&&(this.branchmapping[i]=l,t=!0)}t&&null==this.onchange_debounce&&(this.onchange_debounce=this.$timeout(this._onChange,100))}),t&&null==this.onchange_debounce&&(this.onchange_debounce=this.$timeout(this._onChang
 e,100))}}getBuildProperty(e,t){return e&&e.hasOwnProperty(t)?e[t][0]:null}onChange(e){0!==this.builds.length&&0!==this.all_builders.length&&this.changes.$resolved&&0!==this.buildsets.length&&0!==this.buildrequests&&null==this.onchange_debounce&&(this.onchange_debounce=this.$timeout(this._onChange,100))}_onChange(){var e,t;this.onchange_debounce=void 0;for(var i=0,s=Array.from(this.builds);i<s.length;i++)e=s[i],this.all_builders.get(e.builderid).hasBuild=!0;this.sortBuildersByTags(this.all_builders),null==this.changesBySSID&&(this.changesBySSID={}),null==this.changesByRevision&&(this.changesByRevision={});for(var l=0,n=Array.from(this.changes);l<n.length;l++)t=n[l],this.changesBySSID[t.sourcestamp.ssid]=t,this.changesByRevision[t.revision]=t,this.populateChange(t);for(var r=0,a=Array.from(this.fakechanges);r<a.length;r++)t=a[r],this.populateChange(t);for(var o=0,d=Array.from(this.builds);o<d.length;o++)e=d[o],this.matchBuildWithChange(e);for(var u in this.filtered_changes=[],this.cha
 ngesBySSID){(t=this.changesBySSID[u]).comments&&(t.subject=t.comments.split("\n")[0]);for(var c=0,h=Array.from(t.builders);c<h.length;c++){if(h[c].builds.length>0){this.filtered_changes.push(t);break}}}}sortBuildersByTags(e){for(var t,i,s=[],l="",n=0,r=Array.from(e);n<r.length;n++){var a=r[n];a.hasBuild&&"indexing"!=a.name&&(s.push(a),l+=".".concat(a.builderid))}if(l!==this.last_builderids_with_builds){for(var o={},d=0,u=Array.from(s);d<u.length;d++)if(null!=(t=u[d]).tags&&t.tags.length)for(var c=0,h=Array.from(t.tags);c<h.length;c++)null==o[i=h[c]]&&(o[i]=[]),o[i].push(t);else null==o[""]&&(o[""]=[]),o[""].push(t);var p=this;for(i in o)o[i].sort((e,t)=>p.strcompare(e.name,t.name));var g=[];for(i in o)""!=i&&g.push({name:o[i][0].name,tag:i,builders:o[i],colspan:o[i].length});for(t in o[""])g.push({name:o[""][t].name,tag:"",builders:[o[""][t]],colspan:1});g.sort((e,t)=>p.strcompare(e.name,t.name));var b=[];for(var m in g)for(t in g[m].builders)b.push(g[m].builders[t]);return this.bui
 lders=b,this.buildergroups=g,this.tag_lines=[],this.last_builderids_with_builds=l}}populateChange(e){e.builders=[],e.buildersById={};for(var t=0,i=Array.from(this.buildergroups);t<i.length;t++){for(var s=i[t],l={name:s.name,builds:[],builders:[],colspan:s.builders.length},n=0,r=Array.from(s.builders);n<r.length;n++){var a=r[n];l.builders.push(a),e.buildersById[a.builderid]=l}e.builders.push(l)}}matchBuildWithChange(e){var t,i,s=this.buildrequests.get(e.buildrequestid);if(null!=s){var l=this.buildsets.get(s.buildsetid);if(null!=l){if(null!=(null!=e.properties?e.properties.yp_build_revision:void 0)||this.revmapping[e.buildid]){i=null!=(null!=e.properties?e.properties.yp_build_revision:void 0)?e.properties.yp_build_revision[0]:this.revmapping[e.buildid],null==(t=this.changesByRevision[i])&&(t=this.changesBySSID[i]),null==t&&(t=this.makeFakeChange(i,e.started_at,i),this.fakechanges.push(t)),t.caption="Commit",null!=(null!=e.properties?e.properties.yp_build_branch:void 0)&&(t.caption=e.p
 roperties.yp_build_branch[0]),this.branchmapping[e.buildid]&&(t.caption=this.branchmapping[e.buildid]),t.revlink="http://git.yoctoproject.org/cgit.cgi/poky/commit/?id="+i,t.errorlink="http://errors.yoctoproject.org/Errors/Latest/?filter="+i+"&type=commit&limit=150";e.buildid;null!=l&&null!=l.parent_buildid&&l.parent_buildid,null!=(null!=e.properties?e.properties.reason:void 0)&&(t.reason=e.properties.reason[0]),null!=(null!=e.properties?e.properties.publish_destination:void 0)&&(t.publishurl=e.properties.publish_destination[0].replace("/srv/autobuilder/autobuilder.yoctoproject.org/","https://autobuilder.yocto.io/"),t.publishurl=t.publishurl.replace("/srv/autobuilder/autobuilder.yocto.io/","https://autobuilder.yocto.io/"))}else i="Unresolved Revision",null==t&&(t=this.changesBySSID[i]),null==t&&((t=this.makeFakeChange(i,e.started_at,i)).caption=i,this.fakechanges.push(t));e.builderid in t.buildersById&&t.buildersById[e.builderid].builds.push(e)}}}makeFakeChange(e,t,i){var s={revision
 :e,changeid:e,when_timestamp:t,comments:i};return this.changesBySSID[e]=s,this.populateChange(s),s}openAll(){return Array.from(this.filtered_changes).map(e=>e.show_details=!0)}closeAll(){return Array.from(this.filtered_changes).map(e=>e.show_details=!1)}getRowHeaderWidth(){return this.hasExpanded()?400:200}getColHeaderHeight(){for(var e=0,t=0,i=Array.from(this.builders);t<i.length;t++){var s=i[t];e=Math.max(s.name.length,e)}return Math.max(100,3*e)}isBigTable(){var e=this.getRowHeaderWidth();return(this.$window.innerWidth-e)/this.builders.length<40}hasExpanded(){for(var e=0,t=Array.from(this.changes);e<t.length;e++){var i=t[e];if(this.infoIsExpanded(i))return!0}return!1}selectBuild(e){return this.$uibModal.open({template:i(6),controller:"consoleModalController as modal",windowClass:"modal-big",resolve:{selectedBuild:()=>e}})}toggleInfo(e){return e.show_details=!e.show_details}infoIsExpanded(e){return e.show_details}}]),i(7),i(8),i(10)},function(t,i){t.exports=e},function(e,i){e.expo
 rts=t},function(e,t){e.exports=i},function(e,t){e.exports=s},function(e,t){e.exports=window.T["console_view/views/console.html"]||'<div class="console no-select"><div class="load-indicator" ng-hide="c.builds.$resolved &amp;&amp; c.changes.$resolved &amp;&amp; c.buildrequests.$resolved &amp;&amp; c.buildsets.$resolved"><div class="spinner"><i class="fa fa-circle-o-notch fa-spin fa-2x"></i><p>loading</p></div></div><div ng-show="c.changes.$resolved &amp;&amp; c.filtered_changes.length==0"><p>No changes. Console view needs changesource to be setup, and<a href="#changes">changes</a>to be in the system.</p></div><table class="table table-striped table-bordered" ng-hide="c.filtered_changes.length==0" ng-class="{\'table-fixedwidth\': c.isBigTable()}"><tr class="first-row"><th class="row-header" ng-style="{\'width\': c.getRowHeaderWidth()}"><i class="fa fa-plus-circle pull-left" ng-click="c.openAll()" uib-tooltip="Open information for all changes" uib-tooltip-placement="right"></i><i class=
 "fa fa-minus-circle pull-left" ng-click="c.closeAll()" uib-tooltip="Close information for all changes" uib-tooltip-placement="right"></i></th><th class="column" ng-repeat="builder in c.builders"><span class="builder" ng-style="{\'margin-top\': c.getColHeaderHeight()}"><a ng-href="#/builders/{{ builder.builderid }}" ng-bind="builder.name"></a></span></th></tr><tr class="tag_row"><td class="row-header"></td><td ng-repeat="buildergroup in c.buildergroups" colspan="{{buildergroup.colspan}}" ng-style="{\'text-align\': \'center\'}">{{buildergroup.tag}}</td></tr><tr ng-repeat="change in c.filtered_changes | orderBy: [\'-when_timestamp\'] track by change.changeid"><td><yoctochangedetails change="change"></yoctochangedetails></td><td class="column" ng-repeat="builder in change.builders" colspan="{{builder.colspan}}"><span ng-repeat="build in builder.builds | orderBy: [\'number\']"><script type="text/ng-template" id="buildsummarytooltip"><buildsummary buildid="build.buildid" type="tooltip"></
 buildsummary><\/script><span class="badge-status" ng-if="build.buildid" uib-tooltip-template="\'buildsummarytooltip\'" tooltip-class="buildsummarytooltipstyle" tooltip-placement="auto left-bottom" tooltip-popup-delay="400" tooltip-popup-close-delay="400" ng-class="c.results2class(build, \'pulse\')" ng-click="c.selectBuild(build)">{{ build.number }}</span></span></td></tr></table></div>'},function(e,t){e.exports=window.T["console_view/views/modal.html"]||'\x3c!-- Show build summary for the selected build in a modal window--\x3e<div class="modal-header"><i class="fa fa-times pull-right" ng-click="modal.close()"></i><h4 class="modal-title">Build summary</h4></div><div class="modal-body"><buildsummary ng-if="modal.selectedBuild" buildid="modal.selectedBuild.buildid"></buildsummary></div>'},function(e,t){angular.module("yocto_console_view").controller("consoleModalController",["$scope","$uibModalInstance","selectedBuild",class ConsoleModal{constructor(e,t,i){this.$uibModalInstance=t,this
 .selectedBuild=i,e.$on("$stateChangeStart",()=>this.close())}close(){return this.$uibModalInstance.close()}}])},function(e,t,i){angular.module("yocto_console_view").directive("releaseselectorfield",[class Releaseselectorfield{constructor(){return{replace:!1,restrict:"E",scope:!1,template:i(9),controller:"_ReleaseselectorfieldController"}}}]).controller("_ReleaseselectorfieldController",["$scope","$http",class _releaseselectorfield{constructor(e,t){for(var i=e;null!=i&&null==i.rootfield;)i=i.$parent;if(null!=i){var s={},l=e=>Array.from(e).map(e=>null!=e.fields?l(e.fields):s[e.fullName]=e);l(i.rootfield.fields),e.$watch("field.value",(function(t,i){var l=e.field.selectors[t];if(null!=l)return(()=>{var e=[];for(var t in l){var i=l[t];t in s&&e.push(s[t].value=i)}return e})()}))}else console.log("rootfield not found!?!?")}}])},function(e,t){e.exports=window.T["console_view/views/releaseselectorfield.html"]||'<basefield><label class="control-label col-sm-2" for="{{field.name}}">{{field.l
 abel}}</label><div class="col-sm-10"><select class="form-control" ng-model="field.value" ng-options="v for v in field.choices"></select></div></basefield>'},function(e,t,i){angular.module("yocto_console_view").directive("yoctochangedetails",[class Yoctochangedetails{constructor(){return{replace:!0,restrict:"E",scope:{change:"=",compact:"=?"},template:i(11)}}}])},function(e,t){e.exports=window.T["console_view/views/yoctochangedetails.html"]||'<div class="yoctochangedetails" style="width:100%;"><div style="width:100%;" ng-click="change.show_details = !change.show_details"><a ng-if="change.revlink" ng-href="{{change.revlink}}" uib-tooltip="{{change.comments}}">{{ change.caption }} &nbsp;</a><a ng-if="change.errorlink" ng-href="{{change.errorlink}}">{{ "Errors" }} &nbsp;</a><a ng-if="change.publishurl" ng-href="{{change.publishurl}}">{{ "Output" }} &nbsp;</a><span ng-if="!change.revlink" uib-tooltip="{{change.comments}}">{{ change.caption }} &nbsp;</span><span ng-if="!compact" uib-toolt
 ip="{{change.when_timestamp | dateformat:\'LLL\'}}">({{ change.when_timestamp | timeago }}) &nbsp;</span><i class="fa fa-chevron-circle-right rotate clickable" ng-class="{\'fa-rotate-90\':change.show_details}"></i></div><div class="anim-changedetails" ng-show="change.show_details"><table class="table table-striped table-condensed" ng-show="change.show_details"><tr ng-show="change.reason"><td>Reason</td><td>{{ change.reason }}</td></tr><tr ng-show="change.author"><td>Author</td><td>{{ change.author }}</td></tr><tr><td>Date</td><td>{{ change.when_timestamp | dateformat:\'LLL\'}} ({{ change.when_timestamp | timeago }})</td></tr><tr ng-show="change.repository"><td>Repository</td><td>{{ change.repository }}</td></tr><tr ng-show="change.branch"><td>Branch</td><td>{{ change.branch }}</td></tr><tr><td>Revision</td><td> <a ng-if="change.revlink" ng-href="{{change.revlink}}"> {{ change.revision }}</a></td></tr></table><h5>Comment</h5><pre>{{ change.comments }}</pre><h5>Changed files</h5><ul><
 li ng-repeat="file in change.files">{{file}}</li></ul><p ng-hide="change.files.length">No files</p></div></div>'}])}));
-//# sourceMappingURL=scripts.js.map
\ No newline at end of file
diff --git a/yocto_console_view/yocto_console_view/static/scripts.js.map b/yocto_console_view/yocto_console_view/static/scripts.js.map
deleted file mode 100644
index 79b388a85659..000000000000
--- a/yocto_console_view/yocto_console_view/static/scripts.js.map
+++ /dev/null
@@ -1 +0,0 @@
-{"version":3,"sources":["webpack://yocto-console-view/webpack/universalModuleDefinition","webpack://yocto-console-view/webpack/bootstrap","webpack://yocto-console-view/./src/module/main.module.js","webpack://yocto-console-view/external \"angular-animate\"","webpack://yocto-console-view/external \"@uirouter/angularjs\"","webpack://yocto-console-view/external \"guanlecoja-ui\"","webpack://yocto-console-view/external \"buildbot-data-js\"","webpack://yocto-console-view/./src/module/console.tpl.jade","webpack://yocto-console-view/./src/module/view/modal/modal.tpl.jade","webpack://yocto-console-view/./src/module/view/modal/modal.controller.js","webpack://yocto-console-view/./src/module/releaseselectorfield.directive.js","webpack://yocto-console-view/./src/module/releaseselectorfield.tpl.jade","webpack://yocto-console-view/./src/module/yoctochangedetails.directive.js","webpack://yocto-console-view/./src/module/yoctochangedetails.tpl.jade"],"names":["root","factory","exports","module","requ
 ire","define","amd","self","this","__WEBPACK_EXTERNAL_MODULE__1__","__WEBPACK_EXTERNAL_MODULE__2__","__WEBPACK_EXTERNAL_MODULE__3__","__WEBPACK_EXTERNAL_MODULE__4__","installedModules","__webpack_require__","moduleId","i","l","modules","call","m","c","d","name","getter","o","Object","defineProperty","enumerable","get","r","Symbol","toStringTag","value","t","mode","__esModule","ns","create","key","bind","n","object","property","prototype","hasOwnProperty","p","s","angular","config","ConsoleState","constructor","$stateProvider","glMenuServiceProvider","bbSettingsServiceProvider","addGroup","caption","icon","order","cfg","group","state","controller","concat","controllerAs","template","url","data","addSettingsGroup","items","type","default_value","Console","$scope","$q","$window","dataService","bbSettingsService","resultsService","$uibModal","$timeout","onChange","_onChange","matchBuildWithChange","makeFakeChange","extend","settings","getSettingsGroup","buildLimit","changeLimit","dataAc
 cessor","open","closeOnDestroy","_infoIsExpanded","all_builders","getBuilders","builders","buildergroups","Intl","collator","Collator","undefined","numeric","sensitivity","strcompare","compare","a","b","revmapping","branchmapping","builds","getBuilds","limit","changes","getChanges","fakechanges","buildrequests","getBuildrequests","buildsets","getBuildsets","onNew","build","change","buildid","properties","yp_build_revision","yp_build_branch","complete_at","getProperties","endpoint","split","rev","getBuildProperty","branch","onchange_debounce","length","$resolved","_i","_Array$from","Array","from","builderid","hasBuild","sortBuildersByTags","changesBySSID","changesByRevision","_i2","_Array$from2","sourcestamp","ssid","revision","populateChange","_i3","_Array$from3","_i4","_Array$from4","filtered_changes","comments","subject","_i5","_Array$from5","push","builder","tag","builders_with_builds","builderids_with_builds","_i6","_Array$from6","last_builderids_with_builds","builders_by_tags",
 "_i7","_Array$from7","tags","_i8","_Array$from8","sort","colspan","sorted_builders","tag_lines","buildersById","_i9","_Array$from9","buildergroup","builderg","_i10","_Array$from10","buildrequest","buildrequestid","buildset","buildsetid","started_at","revlink","errorlink","parent_buildid","reason","publish_destination","publishurl","replace","when_timestamp","changeid","openAll","map","show_details","closeAll","getRowHeaderWidth","hasExpanded","getColHeaderHeight","max_buildername","_i11","_Array$from11","Math","max","isBigTable","padding","innerWidth","_i12","_Array$from12","infoIsExpanded","selectBuild","windowClass","resolve","selectedBuild","toggleInfo","window","T","ConsoleModal","$uibModalInstance","$on","close","directive","Releaseselectorfield","restrict","scope","_releaseselectorfield","$http","rootfield","$parent","fields_ref","gatherFields","fields","field","fullName","$watch","selector","selectors","result","k","v","console","log","Yoctochangedetails","compact"],"mappings
 ":"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","file":"scripts.js","sourcesContent":["(function webpackUniversalModuleDefinition(root, factory) {\n\tif(typeof exports === 'object' && typeof module === 'object')\n\t\tmodule.exports = factory(require(\"angular-animate\"), require(\"@uirouter/angularjs\"), require(\"guanlecoja-ui\"), require(\"buildbot-data-js\"));\n\telse if(typeof define === 'function' && define.amd)\n\t\tdefine(\"yocto-console-view\", [\"angular-animate\", \"@uirouter/angularjs\", \"guanlecoja-ui\", \"buildbot-data-js\"], factory);\n\telse if(typeo
 f exports === 'object')\n\t\texports[\"yocto-console-view\"] = factory(require(\"angular-animate\"), require(\"@uirouter/angularjs\"), require(\"guanlecoja-ui\"), require(\"buildbot-data-js\"));\n\telse\n\t\troot[\"yocto-console-view\"] = factory(root[\"angular-animate\"], root[\"@uirouter/angularjs\"], root[\"guanlecoja-ui\"], root[\"buildbot-data-js\"]);\n})((typeof self !== 'undefined' ? self : this), function(__WEBPACK_EXTERNAL_MODULE__1__, __WEBPACK_EXTERNAL_MODULE__2__, __WEBPACK_EXTERNAL_MODULE__3__, __WEBPACK_EXTERNAL_MODULE__4__) {\nreturn "," \t// The module cache\n \tvar installedModules = {};\n\n \t// The require function\n \tfunction __webpack_require__(moduleId) {\n\n \t\t// Check if module is in cache\n \t\tif(installedModules[moduleId]) {\n \t\t\treturn installedModules[moduleId].exports;\n \t\t}\n \t\t// Create a new module (and put it into the cache)\n \t\tvar module = installedModules[moduleId] = {\n \t\t\ti: moduleId,\n \t\t\tl: false,\n \t\t\texports: {}\n \t\t}
 ;\n\n \t\t// Execute the module function\n \t\tmodules[moduleId].call(module.exports, module, module.exports, __webpack_require__);\n\n \t\t// Flag the module as loaded\n \t\tmodule.l = true;\n\n \t\t// Return the exports of the module\n \t\treturn module.exports;\n \t}\n\n\n \t// expose the modules object (__webpack_modules__)\n \t__webpack_require__.m = modules;\n\n \t// expose the module cache\n \t__webpack_require__.c = installedModules;\n\n \t// define getter function for harmony exports\n \t__webpack_require__.d = function(exports, name, getter) {\n \t\tif(!__webpack_require__.o(exports, name)) {\n \t\t\tObject.defineProperty(exports, name, { enumerable: true, get: getter });\n \t\t}\n \t};\n\n \t// define __esModule on exports\n \t__webpack_require__.r = function(exports) {\n \t\tif(typeof Symbol !== 'undefined' && Symbol.toStringTag) {\n \t\t\tObject.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });\n \t\t}\n \t\tObject.defineProperty(exports, '__esModule', {
  value: true });\n \t};\n\n \t// create a fake namespace object\n \t// mode & 1: value is a module id, require it\n \t// mode & 2: merge all properties of value into the ns\n \t// mode & 4: return value when already ns object\n \t// mode & 8|1: behave like require\n \t__webpack_require__.t = function(value, mode) {\n \t\tif(mode & 1) value = __webpack_require__(value);\n \t\tif(mode & 8) return value;\n \t\tif((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;\n \t\tvar ns = Object.create(null);\n \t\t__webpack_require__.r(ns);\n \t\tObject.defineProperty(ns, 'default', { enumerable: true, value: value });\n \t\tif(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));\n \t\treturn ns;\n \t};\n\n \t// getDefaultExport function for compatibility with non-harmony modules\n \t__webpack_require__.n = function(module) {\n \t\tvar getter = module && module.__esModule
  ?\n \t\t\tfunction getDefault() { return module['default']; } :\n \t\t\tfunction getModuleExports() { return module; };\n \t\t__webpack_require__.d(getter, 'a', getter);\n \t\treturn getter;\n \t};\n\n \t// Object.prototype.hasOwnProperty.call\n \t__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };\n\n \t// __webpack_public_path__\n \t__webpack_require__.p = \"\";\n\n\n \t// Load entry module and return exports\n \treturn __webpack_require__(__webpack_require__.s = 0);\n","/*\n * decaffeinate suggestions:\n * DS101: Remove unnecessary use of Array.from\n * DS102: Remove unnecessary code created because of implicit returns\n * DS205: Consider reworking code to avoid use of IIFEs\n * DS207: Consider shorter variations of null checks\n * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md\n */\n\nimport 'angular-animate';\nimport '@uirouter/angularjs';\nimport 'guanlecoja-ui';\nimpor
 t 'buildbot-data-js';\n\nclass ConsoleState {\n    constructor($stateProvider, glMenuServiceProvider, bbSettingsServiceProvider) {\n\n        // Name of the state\n        const name = 'console';\n\n        // Menu configuration\n        glMenuServiceProvider.addGroup({\n            name,\n            caption: 'Yocto Console View',\n            icon: 'exclamation-circle',\n            order: 5\n        });\n\n        // Configuration\n        const cfg = {\n            group: name,\n            caption: 'Yocto Console View'\n        };\n\n        // Register new state\n        const state = {\n            controller: `${name}Controller`,\n            controllerAs: \"c\",\n            template: require('./console.tpl.jade'),\n            name,\n            url: `/${name}`,\n            data: cfg\n        };\n\n        $stateProvider.state(state);\n\n        bbSettingsServiceProvider.addSettingsGroup({\n            name: 'Console',\n            caption: 'Console related settings',\n  
           items: [{\n                type: 'integer',\n                name: 'buildLimit',\n                caption: 'Number of builds to fetch',\n                default_value: 200\n            }\n            , {\n                type: 'integer',\n                name: 'changeLimit',\n                caption: 'Number of changes to fetch',\n                default_value: 30\n            }\n            ]});\n    }\n}\n\nclass Console {\n    constructor($scope, $q, $window, dataService, bbSettingsService, resultsService,\n        $uibModal, $timeout) {\n        this.onChange = this.onChange.bind(this);\n        this._onChange = this._onChange.bind(this);\n        this.matchBuildWithChange = this.matchBuildWithChange.bind(this);\n        this.makeFakeChange = this.makeFakeChange.bind(this);\n        this.$scope = $scope;\n        this.$window = $window;\n        this.$uibModal = $uibModal;\n        this.$timeout = $timeout;\n        angular.extend(this, resultsService);\n        const 
 settings = bbSettingsService.getSettingsGroup('Console');\n        this.buildLimit = settings.buildLimit.value;\n        this.changeLimit = settings.changeLimit.value;\n        this.dataAccessor = dataService.open().closeOnDestroy(this.$scope);\n        this._infoIsExpanded = {};\n        this.$scope.all_builders = (this.all_builders = this.dataAccessor.getBuilders());\n        this.$scope.builders = (this.builders = []);\n        this.$scope.buildergroups = (this.buildergroups = []);\n        if (typeof Intl !== 'undefined' && Intl !== null) {\n            const collator = new Intl.Collator(undefined, {numeric: true, sensitivity: 'base'});\n            this.strcompare = collator.compare;\n        } else {\n            this.strcompare = function(a, b) {\n                if (a < b) {\n                    return -1;\n                }\n                if (a === b) {\n                    return 0;\n                }\n                return 1;\n            };\n        }\n\n        this.
 $scope.revmapping = (this.revmapping = {});\n        this.$scope.branchmapping = (this.branchmapping = {});\n\n        this.$scope.builds = (this.builds = this.dataAccessor.getBuilds({\n            property: [\"yp_build_revision\", \"yp_build_branch\", \"reason\", \"publish_destination\"],\n            limit: this.buildLimit,\n            order: '-started_at'\n        }));\n        this.changes = this.dataAccessor.getChanges({limit: this.changeLimit, order: '-changeid'});\n        this.$scope.fakechanges = (this.fakechanges = []);\n        this.buildrequests = this.dataAccessor.getBuildrequests({limit: this.buildLimit, order: '-submitted_at'});\n        this.buildsets = this.dataAccessor.getBuildsets({limit: this.buildLimit, order: '-submitted_at'});\n\n        this.builds.onChange = this.onChange;\n        this.changes.onChange = this.onChange;\n        this.buildrequests.onChange = this.onChange;\n        this.buildsets.onChange = this.onChange;\n\n        this.builds.onNew = buil
 d => {\n            let change = false;\n            let {\n                buildid\n            } = build;\n            if ((build.properties != null ? build.properties.yp_build_revision : undefined) != null) {\n                this.revmapping[build.buildid] = build.properties.yp_build_revision[0];\n                change = true;\n            }\n            if ((build.properties != null ? build.properties.yp_build_branch : undefined) != null) {\n                this.branchmapping[build.buildid] = build.properties.yp_build_branch[0];\n                change = true;\n            }\n            if ((!this.revmapping[buildid] || !this.branchmapping[buildid]) && !build.complete_at) {\n                build.getProperties().onChange = properties => {\n                    change = false;\n                    buildid = properties.endpoint.split('/')[1];\n                    if (!this.revmapping[buildid]) {\n                        const rev = this.getBuildProperty(properties[0], 'yp_build_r
 evision');\n                        if (rev != null) {\n                            this.revmapping[buildid] = rev;\n                            change = true;\n                        }\n                    }\n                    if (!this.branchmapping[buildid]) {\n                        const branch = this.getBuildProperty(properties[0], 'yp_build_branch');\n                        if (branch != null) {\n                            this.branchmapping[buildid] = branch;\n                            change = true;\n                        }\n                    }\n                    if (change && (this.onchange_debounce == null)) {\n                        this.onchange_debounce = this.$timeout(this._onChange, 100);\n                    }\n                };\n            }\n            if (change && (this.onchange_debounce == null)) {\n                this.onchange_debounce = this.$timeout(this._onChange, 100);\n            }\n        };\n    }\n\n    getBuildProperty(properties,
  property) {\n        const hasProperty = properties && properties.hasOwnProperty(property);\n        if (hasProperty) { return properties[property][0]; } else { return null; }\n    }\n\n    onChange(s) {\n        // if there is no data, no need to try and build something.\n        if ((this.builds.length === 0) || (this.all_builders.length === 0) || !this.changes.$resolved ||\n                (this.buildsets.length === 0) || (this.buildrequests === 0)) {\n            return;\n        }\n        if ((this.onchange_debounce == null)) {\n            this.onchange_debounce = this.$timeout(this._onChange, 100);\n        }\n    }\n\n    _onChange() {\n        let build, change;\n        this.onchange_debounce = undefined;\n        // we only display builders who actually have builds\n        for (build of Array.from(this.builds)) {\n            this.all_builders.get(build.builderid).hasBuild = true;\n        }\n\n        this.sortBuildersByTags(this.all_builders);\n\n        if (this.cha
 ngesBySSID == null) { this.changesBySSID = {}; }\n        if (this.changesByRevision == null) { this.changesByRevision = {}; }\n        for (change of Array.from(this.changes)) {\n            this.changesBySSID[change.sourcestamp.ssid] = change;\n            this.changesByRevision[change.revision] = change;\n            this.populateChange(change);\n        }\n        for (change of Array.from(this.fakechanges)) {\n            this.populateChange(change);\n        }\n\n        for (build of Array.from(this.builds)) {\n            this.matchBuildWithChange(build);\n        }\n\n        this.filtered_changes = [];\n\n        for (let ssid in this.changesBySSID) {\n            change = this.changesBySSID[ssid];\n            if (change.comments) {\n                change.subject = change.comments.split(\"\\n\")[0];\n            }\n            for (let builder of Array.from(change.builders)) {\n                if (builder.builds.length > 0) {\n                    this.filtered_changes.pu
 sh(change);\n                    break;\n                }\n            }\n        }\n    }\n    /*\n     * Sort builders by tags\n     * Buildbot eight has the category option, but it was only limited to one category per builder,\n     * which make it easy to sort by category\n     * Here, we have multiple tags per builder, we need to try to group builders with same tags together\n     * The algorithm is rather twisted. It is a first try at the concept of grouping builders by tags..\n     */\n\n    sortBuildersByTags(all_builders) {\n        // first we only want builders with builds\n        let builder, builders, tag;\n        const builders_with_builds = [];\n        let builderids_with_builds = \"\";\n        for (let builder of Array.from(all_builders)) {\n            if (builder.hasBuild && builder.name != 'indexing') {\n                builders_with_builds.push(builder);\n                builderids_with_builds += `.${builder.builderid}`;\n            }\n        }\n\n        
 if (builderids_with_builds === this.last_builderids_with_builds) {\n            // don't recalculate if it hasn't changed!\n            return;\n        }\n\n        const builders_by_tags = {};\n        for (builder of Array.from(builders_with_builds)) {\n            if (builder.tags != null && builder.tags.length) {\n                for (tag of Array.from(builder.tags)) {\n                    if ((builders_by_tags[tag] == null)) {\n                        builders_by_tags[tag] = [];\n                    }\n                    builders_by_tags[tag].push(builder);\n                }\n            } else {\n                if ((builders_by_tags[''] == null)) {\n                    builders_by_tags[''] = [];\n                }\n                builders_by_tags[''].push(builder);\n            }\n        }\n\n        const self = this;\n        for (tag in builders_by_tags) {\n            builders_by_tags[tag].sort((a, b) => self.strcompare(a.name, b.name));\n        }\n        let build
 ergroups = [];\n        for (tag in builders_by_tags) {\n            if (tag != '') {\n                buildergroups.push({\n                    name: builders_by_tags[tag][0].name,\n                    tag: tag,\n                    builders: builders_by_tags[tag],\n                    colspan: builders_by_tags[tag].length\n                });\n            }\n        }\n        for (builder in builders_by_tags['']) {\n            buildergroups.push({\n                name: builders_by_tags[''][builder].name,\n                tag: '',\n                builders: [builders_by_tags[''][builder]],\n                colspan: 1\n            });\n        }\n\n        buildergroups.sort((a, b) => self.strcompare(a.name, b.name));\n\n        let sorted_builders = [];\n        for (let group in buildergroups) {\n            for (builder in buildergroups[group].builders) {\n                sorted_builders.push(buildergroups[group].builders[builder])\n            }\n        }\n\n        this.bui
 lders = sorted_builders;\n        this.buildergroups = buildergroups;\n        this.tag_lines = [];\n        return this.last_builderids_with_builds = builderids_with_builds;\n    }\n\n    /*\n     * fill a change with a list of builders\n     */\n    populateChange(change) {\n        change.builders = [];\n        change.buildersById = {};\n        for (let buildergroup of Array.from(this.buildergroups)) {\n            let builderg = {name: buildergroup.name, builds: [], builders: [], colspan: buildergroup.builders.length};\n            for (let builder of Array.from(buildergroup.builders)) {\n                builderg.builders.push(builder);\n                change.buildersById[builder.builderid] = builderg;\n            }\n            change.builders.push(builderg);\n        }\n    }\n    /*\n     * Match builds with a change\n     */\n    matchBuildWithChange(build) {\n        let change, oldrev, rev;\n        const buildrequest = this.buildrequests.get(build.buildrequestid);\n  
       if ((buildrequest == null)) {\n            return;\n        }\n        const buildset = this.buildsets.get(buildrequest.buildsetid);\n        if ((buildset == null)) {\n            return;\n        }\n\n        if (((build.properties != null ? build.properties.yp_build_revision : undefined) != null) || this.revmapping[build.buildid]) {\n            if ((build.properties != null ? build.properties.yp_build_revision : undefined) != null) {\n                rev = build.properties.yp_build_revision[0];\n            } else {\n                rev = this.revmapping[build.buildid];\n            }\n            change = this.changesByRevision[rev];\n            if ((change == null)) {\n                change = this.changesBySSID[rev];\n            }\n            if ((change == null)) {\n                change = this.makeFakeChange(rev, build.started_at, rev);\n                this.fakechanges.push(change)\n            }\n\n            change.caption = \"Commit\";\n            if ((build
 .properties != null ? build.properties.yp_build_branch : undefined) != null) {\n                change.caption = build.properties.yp_build_branch[0];\n            }\n            if (this.branchmapping[build.buildid]) {\n                change.caption = this.branchmapping[build.buildid];\n            }\n            change.revlink = \"http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=\" + rev;\n            change.errorlink = \"http://errors.yoctoproject.org/Errors/Latest/?filter=\" + rev + \"&type=commit&limit=150\";\n            let bid = build.buildid;\n            if ((buildset != null) && (buildset.parent_buildid != null)) {\n                bid = buildset.parent_buildid;\n            }\n            if ((build.properties != null ? build.properties.reason : undefined) != null) {\n                change.reason = build.properties.reason[0];\n            }\n            if ((build.properties != null ? build.properties.publish_destination : undefined) != null) {\n                chan
 ge.publishurl = build.properties.publish_destination[0].replace(\"/srv/autobuilder/autobuilder.yoctoproject.org/\", \"https://autobuilder.yocto.io/\");\n                change.publishurl = change.publishurl.replace(\"/srv/autobuilder/autobuilder.yocto.io/\", \"https://autobuilder.yocto.io/\");\n            }\n\n        } else {\n            rev = `Unresolved Revision`;\n            if ((change == null)) {\n                change = this.changesBySSID[rev];\n            }\n            if ((change == null)) {\n                change = this.makeFakeChange(rev, build.started_at, rev);\n                change.caption = rev;\n               this.fakechanges.push(change)\n            }\n\n        }\n\n        if (build.builderid in change.buildersById) {\n            change.buildersById[build.builderid].builds.push(build);\n        }\n    }\n\n    makeFakeChange(revision, when_timestamp, comments) {\n        const change = {\n            revision,\n            changeid: revision,\n         
    when_timestamp,\n            comments\n        };\n        this.changesBySSID[revision] = change;\n        this.populateChange(change);\n        return change;\n    }\n    /*\n     * Open all change row information\n     */\n    openAll() {\n        return Array.from(this.filtered_changes).map((change) =>\n            (change.show_details = true));\n    }\n\n    /*\n     * Close all change row information\n     */\n    closeAll() {\n        return Array.from(this.filtered_changes).map((change) =>\n            (change.show_details = false));\n    }\n\n    /*\n     * Calculate row header (aka first column) width\n     * depending if we display commit comment, we reserve more space\n     */\n    getRowHeaderWidth() {\n        if (this.hasExpanded()) {\n            return 400;  // magic value enough to hold 78 characters lines\n        } else {\n            return 200;\n        }\n    }\n    /*\n     * Calculate col header (aka first row) height\n     * It depends on the length of th
 e longest builder\n     */\n    getColHeaderHeight() {\n        let max_buildername = 0;\n        for (let builder of Array.from(this.builders)) {\n            max_buildername = Math.max(builder.name.length, max_buildername);\n        }\n        return Math.max(100, max_buildername * 3);\n    }\n\n    /*\n     *\n     * Determine if we use a 100% width table or if we allow horizontal scrollbar\n     * depending on number of builders, and size of window, we need a fixed column size or a 100% width table\n     *\n     */\n    isBigTable() {\n        const padding = this.getRowHeaderWidth();\n        if (((this.$window.innerWidth - padding) / this.builders.length) < 40) {\n            return true;\n        }\n        return false;\n    }\n    /*\n     *\n     * do we have at least one change expanded?\n     *\n     */\n    hasExpanded() {\n        for (let change of Array.from(this.changes)) {\n            if (this.infoIsExpanded(change)) {\n                return true;\n            }\
 n        }\n        return false;\n    }\n\n    /*\n     *\n     * display build details\n     *\n     */\n    selectBuild(build) {\n        let modal;\n        return modal = this.$uibModal.open({\n            template: require('./view/modal/modal.tpl.jade'),\n            controller: 'consoleModalController as modal',\n            windowClass: 'modal-big',\n            resolve: {\n                selectedBuild() { return build; }\n            }\n        });\n    }\n\n    /*\n     *\n     * toggle display of additional info for that change\n     *\n     */\n    toggleInfo(change) {\n        return change.show_details = !change.show_details;\n    }\n    infoIsExpanded(change) {\n        return change.show_details;\n    }\n}\n\n\nangular.module('yocto_console_view', [\n    'ui.router', 'ui.bootstrap', 'ngAnimate', 'guanlecoja.ui', 'bbData'])\n.config(['$stateProvider', 'glMenuServiceProvider', 'bbSettingsServiceProvider', ConsoleState])\n.controller('consoleController', ['$scope', '$q
 ', '$window', 'dataService', 'bbSettingsService', 'resultsService', '$uibModal', '$timeout', Console]);\n\nrequire('./view/modal/modal.controller.js');\nrequire('./releaseselectorfield.directive.js');\nrequire('./yoctochangedetails.directive.js');\n","module.exports = __WEBPACK_EXTERNAL_MODULE__1__;","module.exports = __WEBPACK_EXTERNAL_MODULE__2__;","module.exports = __WEBPACK_EXTERNAL_MODULE__3__;","module.exports = __WEBPACK_EXTERNAL_MODULE__4__;","module.exports = window.T['console_view/views/console.html'] || \"<div class=\\\"console no-select\\\"><div class=\\\"load-indicator\\\" ng-hide=\\\"c.builds.$resolved &amp;&amp; c.changes.$resolved &amp;&amp; c.buildrequests.$resolved &amp;&amp; c.buildsets.$resolved\\\"><div class=\\\"spinner\\\"><i class=\\\"fa fa-circle-o-notch fa-spin fa-2x\\\"></i><p>loading</p></div></div><div ng-show=\\\"c.changes.$resolved &amp;&amp; c.filtered_changes.length==0\\\"><p>No changes. Console view needs changesource to be setup, and<a href=\\\"#ch
 anges\\\">changes</a>to be in the system.</p></div><table class=\\\"table table-striped table-bordered\\\" ng-hide=\\\"c.filtered_changes.length==0\\\" ng-class=\\\"{'table-fixedwidth': c.isBigTable()}\\\"><tr class=\\\"first-row\\\"><th class=\\\"row-header\\\" ng-style=\\\"{'width': c.getRowHeaderWidth()}\\\"><i class=\\\"fa fa-plus-circle pull-left\\\" ng-click=\\\"c.openAll()\\\" uib-tooltip=\\\"Open information for all changes\\\" uib-tooltip-placement=\\\"right\\\"></i><i class=\\\"fa fa-minus-circle pull-left\\\" ng-click=\\\"c.closeAll()\\\" uib-tooltip=\\\"Close information for all changes\\\" uib-tooltip-placement=\\\"right\\\"></i></th><th class=\\\"column\\\" ng-repeat=\\\"builder in c.builders\\\"><span class=\\\"builder\\\" ng-style=\\\"{'margin-top': c.getColHeaderHeight()}\\\"><a ng-href=\\\"#/builders/{{ builder.builderid }}\\\" ng-bind=\\\"builder.name\\\"></a></span></th></tr><tr class=\\\"tag_row\\\"><td class=\\\"row-header\\\"></td><td ng-repeat=\\\"buildergrou
 p in c.buildergroups\\\" colspan=\\\"{{buildergroup.colspan}}\\\" ng-style=\\\"{'text-align': 'center'}\\\">{{buildergroup.tag}}</td></tr><tr ng-repeat=\\\"change in c.filtered_changes | orderBy: ['-when_timestamp'] track by change.changeid\\\"><td><yoctochangedetails change=\\\"change\\\"></yoctochangedetails></td><td class=\\\"column\\\" ng-repeat=\\\"builder in change.builders\\\" colspan=\\\"{{builder.colspan}}\\\"><span ng-repeat=\\\"build in builder.builds | orderBy: ['number']\\\"><script type=\\\"text/ng-template\\\" id=\\\"buildsummarytooltip\\\"><buildsummary buildid=\\\"build.buildid\\\" type=\\\"tooltip\\\"></buildsummary></script><span class=\\\"badge-status\\\" ng-if=\\\"build.buildid\\\" uib-tooltip-template=\\\"'buildsummarytooltip'\\\" tooltip-class=\\\"buildsummarytooltipstyle\\\" tooltip-placement=\\\"auto left-bottom\\\" tooltip-popup-delay=\\\"400\\\" tooltip-popup-close-delay=\\\"400\\\" ng-class=\\\"c.results2class(build, 'pulse')\\\" ng-click=\\\"c.selectBuil
 d(build)\\\">{{ build.number }}</span></span></td></tr></table></div>\";","module.exports = window.T['console_view/views/modal.html'] || \"<!-- Show build summary for the selected build in a modal window--><div class=\\\"modal-header\\\"><i class=\\\"fa fa-times pull-right\\\" ng-click=\\\"modal.close()\\\"></i><h4 class=\\\"modal-title\\\">Build summary</h4></div><div class=\\\"modal-body\\\"><buildsummary ng-if=\\\"modal.selectedBuild\\\" buildid=\\\"modal.selectedBuild.buildid\\\"></buildsummary></div>\";","/*\n * decaffeinate suggestions:\n * DS102: Remove unnecessary code created because of implicit returns\n * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md\n */\nclass ConsoleModal {\n    constructor($scope, $uibModalInstance, selectedBuild) {\n        this.$uibModalInstance = $uibModalInstance;\n        this.selectedBuild = selectedBuild;\n        $scope.$on('$stateChangeStart', () => {\n            return this.close();\n        });\n  
   }\n\n    close() {\n        return this.$uibModalInstance.close();\n    }\n}\n\n\nangular.module('yocto_console_view')\n.controller('consoleModalController', ['$scope', '$uibModalInstance', 'selectedBuild', ConsoleModal]);\n","/*\n * decaffeinate suggestions:\n * DS002: Fix invalid constructor\n * DS101: Remove unnecessary use of Array.from\n * DS102: Remove unnecessary code created because of implicit returns\n * DS205: Consider reworking code to avoid use of IIFEs\n * DS207: Consider shorter variations of null checks\n * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md\n */\n\nclass Releaseselectorfield {\n    constructor() {\n        return {\n            replace: false,\n            restrict: 'E',\n            scope: false,\n            template: require('./releaseselectorfield.tpl.jade'),\n            controller: '_ReleaseselectorfieldController'\n        };\n    }\n}\n\nclass _releaseselectorfield {\n    constructor($scope, $http) {\n  
       // HACK: we find the rootfield by doing $scope.$parent.$parent\n        let rootfield = $scope;\n        while ((rootfield != null) && (rootfield.rootfield == null)) {\n            rootfield = rootfield.$parent;\n        }\n\n        if ((rootfield == null)) {\n            console.log(\"rootfield not found!?!?\");\n            return;\n        }\n\n        // copy paste of code in forcedialog, which flatten the fields to be able to find easily\n        const fields_ref = {};\n        var gatherFields = fields => Array.from(fields).map((field) =>\n            (field.fields != null) ?\n                gatherFields(field.fields)\n            :\n                (fields_ref[field.fullName] = field));\n\n        gatherFields(rootfield.rootfield.fields);\n\n        // when our field change, we update the fields that we are suppose to\n        $scope.$watch(\"field.value\", function(n, o) {\n\n            const selector = $scope.field.selectors[n];\n            if (selector != null) {
 \n                return (() => {\n                    const result = [];\n                    for (let k in selector) {\n                        const v = selector[k];\n                        if (k in fields_ref) {\n                            result.push(fields_ref[k].value = v);\n                        }\n                    }\n                    return result;\n                })();\n            }\n        });\n    }\n}\n\nangular.module('yocto_console_view')\n.directive('releaseselectorfield', [Releaseselectorfield])\n.controller('_ReleaseselectorfieldController', ['$scope', '$http', _releaseselectorfield])\n","module.exports = window.T['console_view/views/releaseselectorfield.html'] || \"<basefield><label class=\\\"control-label col-sm-2\\\" for=\\\"{{field.name}}\\\">{{field.label}}</label><div class=\\\"col-sm-10\\\"><select class=\\\"form-control\\\" ng-model=\\\"field.value\\\" ng-options=\\\"v for v in field.choices\\\"></select></div></basefield>\";","/*\n * decaffein
 ate suggestions:\n * DS002: Fix invalid constructor\n * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md\n */\nclass Yoctochangedetails {\n    constructor() {\n        return {\n            replace: true,\n            restrict: 'E',\n            scope: {\n                change: '=',\n                compact: '=?'\n            },\n            template: require('./yoctochangedetails.tpl.jade')\n        };\n    }\n}\n\nangular.module('yocto_console_view')\n.directive('yoctochangedetails', [Yoctochangedetails])\n","module.exports = window.T['console_view/views/yoctochangedetails.html'] || \"<div class=\\\"yoctochangedetails\\\" style=\\\"width:100%;\\\"><div style=\\\"width:100%;\\\" ng-click=\\\"change.show_details = !change.show_details\\\"><a ng-if=\\\"change.revlink\\\" ng-href=\\\"{{change.revlink}}\\\" uib-tooltip=\\\"{{change.comments}}\\\">{{ change.caption }} &nbsp;</a><a ng-if=\\\"change.errorlink\\\" ng-href=\\\"{{change.errorlink}}\\\"
 >{{ \\\"Errors\\\" }} &nbsp;</a><a ng-if=\\\"change.publishurl\\\" ng-href=\\\"{{change.publishurl}}\\\">{{ \\\"Output\\\" }} &nbsp;</a><span ng-if=\\\"!change.revlink\\\" uib-tooltip=\\\"{{change.comments}}\\\">{{ change.caption }} &nbsp;</span><span ng-if=\\\"!compact\\\" uib-tooltip=\\\"{{change.when_timestamp | dateformat:'LLL'}}\\\">({{ change.when_timestamp | timeago }}) &nbsp;</span><i class=\\\"fa fa-chevron-circle-right rotate clickable\\\" ng-class=\\\"{'fa-rotate-90':change.show_details}\\\"></i></div><div class=\\\"anim-changedetails\\\" ng-show=\\\"change.show_details\\\"><table class=\\\"table table-striped table-condensed\\\" ng-show=\\\"change.show_details\\\"><tr ng-show=\\\"change.reason\\\"><td>Reason</td><td>{{ change.reason }}</td></tr><tr ng-show=\\\"change.author\\\"><td>Author</td><td>{{ change.author }}</td></tr><tr><td>Date</td><td>{{ change.when_timestamp | dateformat:'LLL'}} ({{ change.when_timestamp | timeago }})</td></tr><tr ng-show=\\\"change.repositor
 y\\\"><td>Repository</td><td>{{ change.repository }}</td></tr><tr ng-show=\\\"change.branch\\\"><td>Branch</td><td>{{ change.branch }}</td></tr><tr><td>Revision</td><td> <a ng-if=\\\"change.revlink\\\" ng-href=\\\"{{change.revlink}}\\\"> {{ change.revision }}</a></td></tr></table><h5>Comment</h5><pre>{{ change.comments }}</pre><h5>Changed files</h5><ul><li ng-repeat=\\\"file in change.files\\\">{{file}}</li></ul><p ng-hide=\\\"change.files.length\\\">No files</p></div></div>\";"],"sourceRoot":""}
\ No newline at end of file
diff --git a/yocto_console_view/yocto_console_view/static/styles.css b/yocto_console_view/yocto_console_view/static/styles.css
deleted file mode 100644
index cdf358b1ac72..000000000000
--- a/yocto_console_view/yocto_console_view/static/styles.css
+++ /dev/null
@@ -1,79 +0,0 @@
-.console .table-fixedwidth {
-  width: initial;
-}
-.console .load-indicator {
-  width: 100%;
-  height: 100%;
-  z-index: 900;
-  background-color: #ffffff;
-  display: table;
-}
-.console .load-indicator .spinner {
-  display: table-cell;
-  vertical-align: middle;
-  text-align: center;
-}
-.console .load-indicator .spinner p {
-  font-weight: 300;
-  margin-top: 10px;
-}
-.console .column {
-  min-width: 40px;
-  max-width: 40px;
-  width: 40px;
-}
-.console table {
-  border: none;
-}
-.console .tag_row td {
-  margin: 0px;
-  padding: 0px;
-}
-.console .tag_row span {
-  position: relative;
-  float: left;
-  font-size: 10px;
-  overflow: hidden;
-  text-decoration: none;
-  white-space: nowrap;
-}
-.console tr.first-row {
-  background-color: #fff !important;
-}
-.console tr.first-row th {
-  border: none;
-  background-color: #fff !important;
-}
-.console tr.first-row .builder {
-  position: relative;
-  float: left;
-  font-size: 12px;
-  text-align: center;
-  transform: rotate(-45deg);
-  transform-origin: 0% 100%;
-  text-decoration: none;
-  white-space: nowrap;
-}
-.console tr.first-row .column {
-  width: 20px;
-  min-width: 20px;
-  max-width: 20px;
-}
-.yoctochangedetails > .no-select > * {
-  margin-left: 0.3em;
-  margin-right: 0.3em;
-}
-.select-editable {
-  position: absolute;
-  top: 0;
-  border: none;
-  margin: 2px;
-  width: 90%;
-  height: 29px;
-}
-.select-editable input:focus {
-  outline: none;
-}
-
-
-/*# sourceMappingURL=styles.css.map*/
\ No newline at end of file
diff --git a/yocto_console_view/yocto_console_view/static/styles.css.map b/yocto_console_view/yocto_console_view/static/styles.css.map
deleted file mode 100644
index c43d1b8c1faa..000000000000
--- a/yocto_console_view/yocto_console_view/static/styles.css.map
+++ /dev/null
@@ -1 +0,0 @@
-{"version":3,"sources":["webpack://yocto-console-view/./src/styles/styles.less"],"names":[],"mappings":"AAAA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA;AACA","file":"styles.css","sourcesContent":[".console .table-fixedwidth {\n  width: initial;\n}\n.console .load-indicator {\n  width: 100%;\n  height: 100%;\n  z-index: 900;\n  background-color: #ffffff;\n  display: table;\n}\n.console .load-indicator .spinner {\n  display: table-cell;\n  vertical-align: middle;\n  text-align: center;\n}\n.console .load-indicator .spinner p {\n  font-weight: 300;\n  margin-top: 10px;\n}\n.console .column {\n  min-width: 40px;\n  max-width: 40px;\n  width: 40px;\n}\n.console table
  {\n  border: none;\n}\n.console .tag_row td {\n  margin: 0px;\n  padding: 0px;\n}\n.console .tag_row span {\n  position: relative;\n  float: left;\n  font-size: 10px;\n  overflow: hidden;\n  text-decoration: none;\n  white-space: nowrap;\n}\n.console tr.first-row {\n  background-color: #fff !important;\n}\n.console tr.first-row th {\n  border: none;\n  background-color: #fff !important;\n}\n.console tr.first-row .builder {\n  position: relative;\n  float: left;\n  font-size: 12px;\n  text-align: center;\n  transform: rotate(-45deg);\n  transform-origin: 0% 100%;\n  text-decoration: none;\n  white-space: nowrap;\n}\n.console tr.first-row .column {\n  width: 20px;\n  min-width: 20px;\n  max-width: 20px;\n}\n.yoctochangedetails > .no-select > * {\n  margin-left: 0.3em;\n  margin-right: 0.3em;\n}\n.select-editable {\n  position: absolute;\n  top: 0;\n  border: none;\n  margin: 2px;\n  width: 90%;\n  height: 29px;\n}\n.select-editable input:focus {\n  outline: none;\n}\n"],"sourceRoot":
 ""}
\ No newline at end of file

-- 
2.39.5


