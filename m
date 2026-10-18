Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DFCCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:23 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22601.1792361002960216671
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=c3/IJ0aI;
 spf=pass (domain: gmail.com, ip: 209.85.215.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c9879395so374530a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361002; x=1792965802; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E00g/+ktgwy4cYs2PVXOK5U1XB5HLNEyGiyt0z8ZZzE=;
        b=c3/IJ0aIh5THanp2ZP0CsxZmDL35fEK9e5ZZdZdrE0fmerRdAxYvUn+8EqujxNr1+t
         0TRFrpfTV+lbbMBlpB0kqF2L6r3cDqZrMsheptDkryuyr1uN7O2I3LV4ZIx5FsYVfPuR
         /l6yqpew1nlqn4394+agB1WYsR/VGCuc9UPWkXtKF2UOnOD112o0klcH/NocS6OhNXnW
         GIV31eFfuqmEiOby81Y/7URxgP1IInA0wct1ltnJAghD+pVM8tRPVh07Uzl1C4Z6Fcy2
         QqeA037QQsnXXWyI5inSYOLzGOo7lc6qEzho66gvx4eE4aQnTv1CM8P5ihzEtESZp6NT
         MgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361002; x=1792965802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E00g/+ktgwy4cYs2PVXOK5U1XB5HLNEyGiyt0z8ZZzE=;
        b=eFmC/y8iE1Puq216H6qX7oMK+6iWp5YBPrki72N1dndQUWAp2RAoAypKboQhMos6YY
         yodMNgJS2eYBgb/Oozhy8248fFngnmVcqKxgFsmayUypc6Wo3VYeBA/pJPTyxUamDFCy
         jOCfKYk1yTHTxW1Zxc2C858wvq9xtCDKqn46agZLVH3EIy+Tk9GEL1SX1/pxBO5IWgHn
         iI2nm4Bv/o7YeuGskWoHEZWYk1IwP87FND/qTvOSR2fVQC69qxwBhvze/QtJyvHK58FH
         TUSlYk/+8pf+uAD6aGf19zoVmiDFTapbjaCSgUahDnqb5MrxxfsusY5wNAEQ/KIiw9zN
         q3Cw==
X-Gm-Message-State: AFq9FYL1imQ77wcUlMbd+8vN+NFEf57TO/WL2ZnR6kgEQWMQNEUN1/f5
	lc8XwIvgkr6EK2tMqPyaou5c5boGDAqQ3TmGD7VMosO9ZoGjENA5+e0vHy/c/EK+
X-Gm-Gg: AYBFou1PFRFaDnMS/6O0cJwM5uemXlP/da5eGWtiMxMg/5TIwJMEvfhG4OFqQPby2if
	DtezIGRY/q9IT8PYdasFn4QohmpgKlJ4QOKhA25PWjnLbwk9+uCHVxfQ9+if70HL1gT5ibEnElD
	tLJpSlk8iBYoBZPOPXZDDTd+h1MQkKz5bhKM/eLsjLJdoPeAhNHpgFlpIh3SHkeYJqoZarkYfDQ
	0zXZ72CBS/XDHWIipMJthbO+gGVR6+6BIEoijr1Stq1i0QE0JjtCRCI5fkIqeGytx9tDI0hh4fI
	pJkSiZ7a8fLrBBh1cyqWX7kz6vac3pYB1qKZWoI/UH9bJ8EIFnLXGkQzaYORjkEK4WF7A0liwAK
	iMOKNJ2liXPu0sFQZf77CMek3gK14+bkdB1/n7nKeK8ne1+DmFU1THmB0BA4L/GTefOIckOkbUk
	/eWWb2WFAfN9p4ci7FauDbVWRqqIRAP1/uCk5wGtWOyH5KYwwUqlN64cOAnsWlfV0WjNnl0oUqW
	3hI3XU6HIblES2K8jWP+nPfVs+u21U=
X-Received: by 2002:a17:90b:4fc8:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3aceefc4effmr4790916a91.18.1792361002242;
        Sun, 18 Oct 2026 15:03:22 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:21 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 04/10] docker/README: remove
Date: Sun, 18 Oct 2026 15:03:02 -0700
Message-ID: <20261018220308.72731-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5086

It has not been updated since 2018 and is superseded by the "Docker
Setup" section of the main README. It still describes a setup.py script,
an internal Intel clone URL and branch, and an Intel proxy.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/README | 52 ---------------------------------------------------
 1 file changed, 52 deletions(-)
 delete mode 100644 docker/README

diff --git a/docker/README b/docker/README
deleted file mode 100644
index 86348a1..0000000
--- a/docker/README
+++ /dev/null
@@ -1,52 +0,0 @@
-Layerindex Docker Setup Instructions
-
-The script setup.py will set up and configure a cluster of 5 docker containers:
-
-  - layersapp: the application
-  - layersdb: the database
-  - layersweb: NGINX web server (as a proxy and for serving static content)
-  - layerscelery: Celery (for running background jobs)
-  - layersrabbit: RabbitMQ (required by Celery)
-
-The script will edit all necessary configuration files, build and launch all containers, and do the initial database setup. It is advised that you start with a .sql database file to prepopulate your database. The following instructions will walk you through the setup.  
-
-1) Install docker and docker-compose per instructions: 
- 	https://docs.docker.com/compose/install/ 
-	** Note: for latest docker-compose version follow the directions above, rather than using apt. 
-
-2) Clone the repo and checkout appropriate branch:
- 	git clone https://github.intel.com/peggleto/layerindex-web.git
- 	git checkout origin/dev_snapshot
-
-2) Run the setup script (dockerstup.py). You can optionally supply your hostname, proxy settings, a sql database file of layer mappings to import, and a host to container port mapping. For more information, run: 
- 	./dockersetup.py -h 
-
-	Example command to run containers with a proxy and with a database to import:
- 	./dockersetup.py -d ~/databasedump.sql -p http://proxy-chain.intel.com:911 
-
- 	During the setup you will be asked for a username, email and password to set up a super user for the database. This will allow you to access the database later, should you need to. 
-
-3) Once the script completes, open a web browser and navigate to <hostname>:<mapped_port>/layerindex. If you haven't supplied hostname and/or port mapping, this will by default be localhost:8080. 
-
-4) If you have chosen to not supply a prepopulated database and are instead starting fresh, you should now
-follow the instructions in the "Database Setup" section of the main README.
-
-5) If you need to rerun this script for any reason a second time, make sure to tear the containers down first with docker-compose down. Otherwise, your new automatically generated root database password will not match.
-
-6) To update the layers in the future, you can optionally do the following: 
-
-	Run the layer updates
-	docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py
-
-	Or do a full refresh
-	docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py -r
-
-
-TROUBLESHOOTING:
-
-- Network issues behind a proxy when building container: On some Ubuntu systems, /etc/resolv.conf is set to 127.0.0.x, rather than your local DNS server. Docker will look there for your DNS server, and when it fails to find it it will default to using a public one (frequently 8.8.8.8). Many corporate proxies blocks public DNS servers, so you will need to manually supply the DNS server to docker using /etc/docker/daemon.json:
-	{"dns": ["xx.xx.xx.xx] }
-
-
-
-
-- 
2.56.0


