Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7DED39010
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 12:50:33 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34919.1768481426224818005
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 04:50:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zcsh6h5R;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F1F31A287B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 12:50:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16130606B6
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 12:50:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEB3810B68606;
	Thu, 15 Jan 2026 13:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768481423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=MiZyeCajRGOAAxQgue1i9kqdnLWsHil3d0JwGbmvGig=;
	b=zcsh6h5Rz1mvFnsOgoT0MoIHHSc8TFwN5MwGhgJsI+rjCTKnrZpewi75Ekpi/ClSYrZieo
	DHb/dDc1+B//ruTW90NYDuSL/yw5JUf089A7eGhkB37kMtA+BATSdLWmU6RbjsqUvYSC2D
	L6UdFi5/Qr6mU6YcMEc+V3YXwKcZIh+B1OTAZmrCqKfxbNw7skX4qWNQtjp68E6WM8N6WU
	P93V3jojqzHMJFd6JNjbawQGwiUerAjSnv4+3jgpd2T33qijaadT7M14qiXN7G5fmgyWpB
	WoCPM0Ox4uVXaDQAqSLxao940KqTthXxQzNjgwDi3lDg7vukF7xFss0N3fkKBw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 15 Jan 2026 13:50:09 +0100
Subject: [swat-tools][PATCH] Display the duration of builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-build-duration-v1-1-4ae71508e060@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIDiaGkC/yXMQQrCMBCF4auUWTvQJNWFVyldJJmpjpRGMkkVS
 u9u1OUH7/07KGdhhWu3Q+ZNVNLaYE4dxLtfb4xCzWB7e+mNcRiqLIRUsy9tiucQZzcMxlkiaKd
 n5lnev+A4/a01PDiWb2XUly9YUlp0guP4ALkBcn1+AAAA
X-Change-ID: 20260113-build-duration-5bcf344132dd
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4349;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=/RdwnRUrq6QYutoKSgM6O+egx0a4C4hPpddj+ivCS5Y=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpaOKOPQXsPodNWRKxRAPPiwhibZ8eempc8hPZr
 DfTUvwQj/eJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWjijgAKCRDRgEFAKaOo
 NiKgEACTauhnB4zh6DmmRzB5nZWl8Bk5r54qN05Hme9hKEKA2gz3X4V2K7oGFspXY7RXokNTBUC
 QZ75wdbGmT3Zmw55znZIHnjYqtHcZTlglKYCB+5z8QAI0IhybENc3lDO4PQBD/Uo7d3WWKbljl+
 T0OGF34h7AvvMD+eFGbbWNjA2E1Af3m4yxn62Cp7AZp5fGewUTpARdOcOcK8MTDDHC8YiZPDj31
 u2JmNdJHpQxfZpnmxLdB1eyhIsMyFicrLFBV4G77zJSmDPQfvy9CokqxVPdWXC0QMDsPaln1vBc
 dLdKH76Xe7n6XHrxBnyrFxU48Bey/eR7fvuV0tcQRpUSl2mA4LE2Ihd76H7et4DVjnUH+qBQnYd
 uZklqYvxkJ+l8o6IVGnFyI+cuLo7Z3R2Fm97rdald2LuqBXTf3cP5wyUHCp8Kf5eW3+YvfxMW6N
 wLwN92LWyyKwYpHZkzymBnLc5QNUJRreQRAAKOzMCWEpbjKx1SW0OXJV/B/NU6oQqwcC4+64EL2
 U27PgEFwo4IEjGsHyp0+qk2png3SyWOgLb61MfVPL2ir2gBtu66bEWHCNVPwOZmKZ35f13ffAZO
 pK6ODJbVL8Uf/wGPBWfoyrkhIatz8OCNjnQjRJzQITJVzqui03HhZYxJjFT5H+6QQpl8rXItFMu
 EP/YLxfx/cwzlzg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 12:50:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2961

It can sometimes be useful to know how long a build took, especially for
hanging builds that were canceled after a while.

Add the start timestamp as data stored in the database, and use it with
completed to display the duration. The start timestamp is not displayed,
only the duration.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 README.md               |  1 +
 swattool/database.py    |  4 +++-
 swattool/initmanager.py |  1 +
 swattool/swatbuild.py   | 11 +++++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 7f44a87..47359e9 100644
--- a/README.md
+++ b/README.md
@@ -237,6 +237,7 @@ Available field names for the `sort` configuration option:
 - `Test` - Test name
 - `Owner` - Assigned owner
 - `Worker` - Worker machine name
+- `Started` - Start timestamp
 - `Completed` - Completion timestamp
 - `SWAT URL` - SWAT interface URL
 - `Autobuilder URL` - Autobuilder URL
diff --git a/swattool/database.py b/swattool/database.py
index 82108dd..d50fbc1 100644
--- a/swattool/database.py
+++ b/swattool/database.py
@@ -28,6 +28,7 @@ SCHEMA = {
         "status",
         "test",
         "worker",
+        "started",
         "completed",
         "collection_id",
         "ab_url",
@@ -280,7 +281,8 @@ class Database:
             cur.execute(
                 "INSERT INTO build VALUES(:build_id, "
                 ":buildbot_build_id, :status, :test, :worker, "
-                ":completed, :collection_id, :ab_url, :parent_id);",
+                ":started, :completed, :collection_id, "
+                ":ab_url, :parent_id);",
                 data,
             )
 
diff --git a/swattool/initmanager.py b/swattool/initmanager.py
index 74932db..526946c 100644
--- a/swattool/initmanager.py
+++ b/swattool/initmanager.py
@@ -326,6 +326,7 @@ class InitManager:
         data["status"] = int(attributes["status"])
         data["test"] = attributes["targetname"]
         data["worker"] = attributes["workername"]
+        data["started"] = attributes["started"]
         data["completed"] = attributes["completed"]
         data["collection_id"] = int(collectionid)
         data["ab_url"] = attributes["url"]
diff --git a/swattool/swatbuild.py b/swattool/swatbuild.py
index edc1ea8..a53fbf5 100644
--- a/swattool/swatbuild.py
+++ b/swattool/swatbuild.py
@@ -102,7 +102,9 @@ class Field(enum.StrEnum):
     TEST = "Test"
     OWNER = "Owner"
     WORKER = "Worker"
+    STARTED = "Started"
     COMPLETED = "Completed"
+    DURATION = "Duration"
     SWAT_URL = "SWAT URL"
     AUTOBUILDER_URL = "Autobuilder URL"
     FAILURES = "Failures"
@@ -123,7 +125,9 @@ class Field(enum.StrEnum):
             cls.TEST,
             cls.OWNER,
             cls.WORKER,
+            cls.STARTED,
             cls.COMPLETED,
+            cls.DURATION,
         ]
 
 
@@ -267,7 +271,9 @@ class Build:
         self.status = Status.from_int(sql_rows[0]["status"])
         self.test = sql_rows[0]["test"]
         self.worker = sql_rows[0]["worker"]
+        self.started = datetime.fromisoformat(sql_rows[0]["started"])
         self.completed = datetime.fromisoformat(sql_rows[0]["completed"])
+        self.duration = self.completed - self.started
         self.swat_url = swat_url
         self.autobuilder_url = sql_rows[0]["ab_url"]
         self.owner = sql_rows[0]["owner"]
@@ -492,8 +498,12 @@ class Build:
         """
         if field == Field.BUILD:
             return self.id
+        if field == Field.STARTED:
+            return self.completed.astimezone().isoformat(timespec="minutes")
         if field == Field.COMPLETED:
             return self.completed.astimezone().isoformat(timespec="minutes")
+        if field == Field.DURATION:
+            return self.duration
         if field == Field.BRANCHES:
             return "&".join(self._get_branches())
         if field.name.lower() in self.__dict__:
@@ -634,6 +644,7 @@ class Build:
             Field.BRANCHES,
             Field.WORKER,
             Field.COMPLETED,
+            Field.DURATION,
             Field.SWAT_URL,
             Field.AUTOBUILDER_URL,
         ]

---
base-commit: 8b38da2933736cbb589a9837e3f1940e925fb842
change-id: 20260113-build-duration-5bcf344132dd


