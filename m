Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371E7C021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 11:00:06 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.86880.1740394804501454295
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 03:00:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Iv1GLn79;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D656F44213;
	Mon, 24 Feb 2025 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740394803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1rcR/TY55VID1ICd3e+c5TYT2kBXVc4rcNM5JoKYzk=;
	b=Iv1GLn79h6eOQZN+jLZc2msx6fhAuoAaQnfGl9wmGq+4eS1YH4qHCwW1+OgGfpLw3xseif
	Gqk2xvXvzHQEpvOIM8Sgg+gN9lBEfEe85+vC09hh/02TGK+m4jVtFoCSVCvVrga1tEy267
	SSgzhgiTP0ZfixPI6YCWg5c5Db9RSx7tU+unfpkcFoRFnnsZP5dRP0cNwht5/1BPdIyGJf
	9glPn6RGsY3JVzVTHg0RihG1yb7AjWMguF+Rkj9pjbef91pUQlihHqvV2iT9SUwRPLTaRT
	k8r47PAJSLOLIfOSqroXIO7Z15WWS4bHgGo1obQ7A68fdVQ7kIW6qbjlOrBcew==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 24 Feb 2025 11:59:31 +0100
Subject: [PATCH layerindex-web 1/2] dockersetup: Switch from mysql to
 mariadb binaries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mathieu-yp-compat-staff-v1-1-9b8d07f00af7@bootlin.com>
References: <20250224-mathieu-yp-compat-staff-v1-0-9b8d07f00af7@bootlin.com>
In-Reply-To: <20250224-mathieu-yp-compat-staff-v1-0-9b8d07f00af7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740394802; l=4185;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=lyT6NVk9dCagpphxM4KehKLat24dKuQphDIZLR8bJxU=;
 b=9JOF0fSgGeZ+mBDGWSXdpZVwj4gWy8QiKHcsNqs54nETDFbaQMs+M9p8LfuGHuwJw0czS4wc1
 JoPXVFbw8QhCy5DpyFkyFpOeBn5IJsVEW851WSy8sR4c+VXuTayxaCp
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgto
 hhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 11:00:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1123

In the last versions of mariadb:lts docker container, the database
management binaries are named mariadb* instead of mysql*. This requires
some small modifications in our scripts.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 README                              | 4 ++--
 dockersetup.py                      | 6 +++---
 layerindex/tools/initial_db_dump.sh | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 89dbd5b8326b..1335b7a97b36 100644
--- a/README
+++ b/README
@@ -412,12 +412,12 @@ To back up the database within the docker-based setup, you can run the
 following command (no need to substitute ${MYSQL_ROOT_PASSWORD}, it's
 already present within the container environment):
 
-docker-compose exec layersdb /bin/sh -c '/usr/bin/mysqldump -u root --password=${MYSQL_ROOT_PASSWORD} --max_allowed_packet=512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
+docker-compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root --password=${MYSQL_ROOT_PASSWORD} --max_allowed_packet=512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
 
 To restore one of these backups you would run the following command (take
 care, this will overwrite the data immediately without prompting!):
 
-zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c '/usr/bin/mysql -u root --password=${MYSQL_ROOT_PASSWORD} layersdb'
+zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c '/usr/bin/mariadb -u root --password=${MYSQL_ROOT_PASSWORD} layersdb'
 
 
 
diff --git a/dockersetup.py b/dockersetup.py
index 21be0dad32a0..bc7478c34bec 100755
--- a/dockersetup.py
+++ b/dockersetup.py
@@ -798,7 +798,7 @@ while True:
     env = os.environ.copy()
     env['MYSQL_PWD'] = dbapassword
     # Dummy command, we just want to establish that the db can be connected to
-    return_code = subprocess.call("echo | docker-compose exec -T -e MYSQL_PWD layersdb mysql -uroot layersdb", shell=True, env=env)
+    return_code = subprocess.call("echo | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb", shell=True, env=env)
     if return_code == 0:
         break
     else:
@@ -820,7 +820,7 @@ if not args.update:
             catcmd = 'cat'
         env = os.environ.copy()
         env['MYSQL_PWD'] = dbapassword
-        return_code = subprocess.call("%s %s | docker-compose exec -T -e MYSQL_PWD layersdb mysql -uroot layersdb" % (catcmd, quote(args.databasefile)), shell=True, env=env)
+        return_code = subprocess.call("%s %s | docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb" % (catcmd, quote(args.databasefile)), shell=True, env=env)
         if return_code != 0:
             print("Database import failed")
             sys.exit(1)
@@ -848,7 +848,7 @@ if not args.update:
         # (avoids password being visible through ps or /proc/<pid>/cmdline)
         env = os.environ.copy()
         env['MYSQL_PWD'] = dbapassword
-        return_code = subprocess.call("docker-compose exec -T -e MYSQL_PWD layersdb mysql -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
+        return_code = subprocess.call("docker-compose exec -T -e MYSQL_PWD layersdb mariadb -uroot layersdb < " + quote(sqlscriptfile), shell=True, env=env)
         if return_code != 0:
             print("Creating database user failed")
             sys.exit(1)
diff --git a/layerindex/tools/initial_db_dump.sh b/layerindex/tools/initial_db_dump.sh
index 1675092e904e..a8648c637fe3 100755
--- a/layerindex/tools/initial_db_dump.sh
+++ b/layerindex/tools/initial_db_dump.sh
@@ -31,9 +31,9 @@ fi
 # This will ask for the password twice, not much we can really do about
 # that though
 # First, get the structure without data
-mysqldump $1 -u root -p --no-data > $2
+mariadb-dump $1 -u root -p --no-data > $2
 # Second, the data with a number of exclusions
-mysqldump $1 -u root -p --no-create-info \
+mariadb-dump $1 -u root -p --no-create-info \
   --ignore-table=$1.auth_group \
   --ignore-table=$1.auth_group_permissions \
   --ignore-table=$1.auth_permission \

-- 
2.39.5


