Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10750.1792771981496183936
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Oct 2026 09:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=qtMqV72J;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860851BA8
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 09:12:57 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 683CF3F673
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792771980; bh=lfOxFkMA3uOr/3HJsvlMBYwVJEaDaeof/wpNSOjdg3g=;
	h=From:To:Subject:Date:From;
	b=qtMqV72JsQucbV0rSEsffqd1n5+4xAM8bhpNbKmCGp2rvJCTV0VfYZ4dm46/CPh0e
	 VgEARJBaWp72Gl1ifeMzF91CuYS6cTItju7/cdCShdbQEhl1+/Et4/GEHQjVk5EosG
	 xzYbhrdw83IJxed5qmXBrnWzFgzjIf9I9bqNL6r8=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] abint: be more verbose
Date: Fri, 23 Oct 2026 17:12:59 +0100
Message-ID: <20261023161259.3751263-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-ARM-No-Footer: NoDisclaimer
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 16:13:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5145
Content-Type: text/plain; charset="utf-8"

Add more logging so if the script produces bad data we can tell from the
output.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/abint/abint.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/abint/abint.py b/scripts/abint/abint.py
index 8c45e6ec..951ea59e 100755
--- a/scripts/abint/abint.py
+++ b/scripts/abint/abint.py
@@ -75,7 +75,7 @@ class Bug:
 def get_data():
     url_re =3D r"(?P<server>https?://.+yocto.+/)#/?builders/(?P<builder>=
\d+)/builds/(?P<build>\d+)"
=20
-    logging.debug("Searching bugzilla for AB-INT bugs...")
+    logging.info("Searching bugzilla for AB-INT bugs...")
     bz =3D bugzilla.Bugzilla("https://bugzilla.yoctoproject.org/rest")
     # add limit=3D5 for speed
     query =3D bz.build_query(
@@ -91,10 +91,12 @@ def get_data():
         for bug in bugs
     ]
=20
-    pprint.pprint(bugs)
-    print(f"Found {len(bugs)} AB-INT bugs")
+    logging.info(f"Found {len(bugs)} AB-INT bugs: {", ".join(str(bug.id)=
 for bug in bugs)}")
=20
+    logging.info("Fetching bugzilla comments...")
     comments_data =3D bz.get_comments([bug.id for bug in bugs])["bugs"]
+
+    logging.info("Scanning for autobuilder link...")
     for bug in bugs:
         for comment in comments_data[str(bug.id)]["comments"]:
             for match in re.finditer(url_re, comment["text"]):
@@ -109,6 +111,7 @@ def get_data():
                     bug.seen.append(started_at)
                 except requests.exceptions.HTTPError as e:
                     logging.debug(f"Couldn't find build for {builder=3D}=
 {build=3D}")
+        logging.info(f"Bug {bug.id} was seen {len(bug.seen)} times")
=20
     json_str =3D json.dumps([bug.to_dict() for bug in bugs], indent=3D2,=
)
=20
@@ -124,8 +127,7 @@ if __name__ =3D=3D "__main__":
     parser.add_argument("--cached", action=3D"store_true", help=3D"Use t=
he local cached data instead of fetching")
     args =3D parser.parse_args()
=20
-    if args.verbose:
-        logging.basicConfig(level=3Dlogging.DEBUG)
+    logging.basicConfig(level=3Dlogging.DEBUG if args.verbose else loggi=
ng.INFO)
=20
     if args.cached:
         logging.debug(f"Loading cached data from {CACHE_NAME}")
--=20
2.43.0

