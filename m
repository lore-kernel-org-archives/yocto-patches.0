Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29B1ECD6E6
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 19:55:59 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27915.1770839751213334997
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 11:55:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b7lkWMmS;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so2058293a91.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839750; x=1771444550; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiF+U4+8DbSF5IOZ30uEZkkjQQhEAOreJA1Yet/PxSg=;
        b=b7lkWMmSUszPAg9qd3SkcczIs17Jq3ZzkOEDrVcPrhMFBVX46+ggl+BGPX+ejXlTJ4
         Qu2MNoT6zlXnRNhvO2wxaaiXet9QRrItYwAeBt82ZrA3m4d5mYzq1BUVlQal5vG6pP3S
         52Iwx+bdDGS0xM/gE2Zh6fh6feKAKje4Uovz59uF8w828/TJqBWT056ljDL9M9JLQbqM
         mD0djpVstQSRl60IxqpmJtnBjyay05V35PAansK4QAl/nYtOh5GdoFlmrQkxvDCANbxK
         pXGpOK5vFFfMwVtom/QpgiWzp2S9Qpw+QwaXIqzMzvHTuAm74btYh52J2e1gPo7PviH7
         JDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839750; x=1771444550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiF+U4+8DbSF5IOZ30uEZkkjQQhEAOreJA1Yet/PxSg=;
        b=U8UewN7wRPGLdlOEy24U45eskT3E1aHyGSEmn9hVYOhPiUX/o1BtHkFrl43xl9Yzd1
         iYd7pw8mKp82A3bVkftagnE2Tnp9p7LTt8gS0iSKtQvZ18Xsen2JyQlWz7nA4Lu+VFBz
         TNTH0Qg2XsG/QmEuG7oQ0rlHVxrcBU5SaM1rM9mYmROksFciQCKGHLCXn5RdBRKFPohs
         eiDVXL1U/0FmWFWR0clddiuqoXqrcIkv+UoxuoVqv266qPgccRbhCbEfQPmL89tIW0Nf
         598oNEwl8+0/aTRQ1JCuYzVWCP1UyeBmntxlOMi8ssjDdn01ts3s2PBo/4CS9ufsYhZ0
         EzvQ==
X-Gm-Message-State: AOJu0YyI4ayQ90EjxU1u4Ysjx/d0zxJQ6Q5rkGHZ/t0eYs6bO/1T3gyJ
	p69gBd24J7jnkRUiLbUgXGnGHr1wqoVuPGt2WShtEy+SxSVEDo94/XvXaZynVg==
X-Gm-Gg: AZuq6aLSvgUT/3eSFksUXgGexNeum4azQOF1mPS9dk6VXmwfWVv9B977JluXwIVz4rm
	K37OUuB7FSQiEphs9dkrLAUGohPb7DzZCKxuVSSmQFQNoTZKmxAk8auQgGIEVcT+E2Pk8WCmaBp
	t8jqSIILf2y8pGFiNYej9gCTmKOykvlXqOEZQ/L98/aaXVrONuFiLtj84a4hkZDOPEhkVsouOUC
	EtK56QyKcDg+/a7Jt5IvL7cAQgnvlDmWM3BaOslvrNoNReneA5v750IkgVd0jLRJAOdIA8JtJxU
	Eh4XN1Cb8+gQe3CT06QXtZ0OIXc4aJYSLIVqem2iEwrjjGvGsOqV6VXmzmQUqEqVlAXV9HeojFW
	4QFxXh5u/xJoXCuJIsCkaAnFfll2mPlpF/QX1yUM/uNm82jYS9QaKEbhFURpQNF4DpmECri2ws3
	lkPEFj7852wn2zyDo/roFaPAF80eAd47IFg1wDmGEvhUGLlvVod9e2VRU2+K4FdnUBAKbg6ODkx
	5BdnJ1QL74ba9qlo7FubtE=
X-Received: by 2002:a17:90b:350c:b0:356:7a0c:372f with SMTP id 98e67ed59e1d1-3568f3e80cdmr526624a91.17.1770839749848;
        Wed, 11 Feb 2026 11:55:49 -0800 (PST)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d621esm2810293b3a.32.2026.02.11.11.55.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 11:55:49 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] rrs: tools: add create_release.py
Date: Wed, 11 Feb 2026 11:55:34 -0800
Message-ID: <20260211195536.10278-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211195536.10278-1-tim.orling@konsulko.com>
References: <20260211195536.10278-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 19:55:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3215

Allow for a new release and milestones to be created from a YAML file input.
Add PyYAML==6.0.3 to requirements.txt

Fixes: [YOCTO #15578]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt            |   1 +
 rrs/tools/create_release.py | 160 ++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100755 rrs/tools/create_release.py

diff --git a/requirements.txt b/requirements.txt
index 7a3806c..767d4bc 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -38,3 +38,4 @@ typing_extensions==4.12.2
 tzdata==2024.1
 vine==5.1.0
 wcwidth==0.2.13
+PyYAML==6.0.3
diff --git a/rrs/tools/create_release.py b/rrs/tools/create_release.py
new file mode 100755
index 0000000..3f14820
--- /dev/null
+++ b/rrs/tools/create_release.py
@@ -0,0 +1,160 @@
+#!/usr/bin/env python3
+
+#
+# Create a new release (and its milestones) from a YAML file.
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import sys
+import os.path
+
+sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), '..')))
+sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), '..', '..', 'layerindex')))
+
+import argparse
+import utils
+import logging
+import yaml
+
+logger = utils.logger_create('CreateRelease')
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Create a new release and milestones from a YAML file",
+        epilog="""Example YAML file:
+
+  release:
+    plan: "OE-Core"
+    name: 5.1
+    start_date: 2024-04-30
+    end_date: 2024-10-25
+    milestones:
+      - name: M1
+        start_date: 2024-04-30
+        end_date: 2024-05-31
+      - name: M2
+        start_date: 2024-06-03
+        end_date: 2024-07-19
+""",
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+    )
+    parser.add_argument("yamlfile", help="Path to YAML file defining the release")
+    parser.add_argument('-d', '--debug', action='store_true',
+                        help='Enable debug output')
+    parser.add_argument('-q', '--quiet', action='store_true',
+                        help='Hide all output except error messages')
+    parser.add_argument('-n', '--dry-run', action='store_true',
+                        help='Do not write any changes')
+    parser.add_argument('--update', action='store_true',
+                        help='Update existing release/milestones if they already exist')
+
+    args = parser.parse_args()
+
+    if args.debug:
+        loglevel = logging.DEBUG
+    elif args.quiet:
+        loglevel = logging.WARNING
+    else:
+        loglevel = logging.INFO
+
+    logger.setLevel(loglevel)
+
+    with open(args.yamlfile, 'r') as f:
+        data = yaml.safe_load(f)
+
+    if 'release' not in data:
+        logger.error("YAML file must contain a top-level 'release' key")
+        sys.exit(1)
+
+    reldata = data['release']
+
+    for field in ('plan', 'name', 'start_date', 'end_date'):
+        if field not in reldata:
+            logger.error("Release is missing required field '%s'" % field)
+            sys.exit(1)
+
+    milestones = reldata.get('milestones', [])
+    for i, ms in enumerate(milestones):
+        for field in ('name', 'start_date', 'end_date'):
+            if field not in ms:
+                logger.error("Milestone %d is missing required field '%s'"
+                             % (i + 1, field))
+                sys.exit(1)
+
+    utils.setup_django()
+    from rrs.models import MaintenancePlan, Release, Milestone
+    from django.db import transaction
+
+    plan_name = str(reldata['plan'])
+    maintplan = MaintenancePlan.objects.filter(name=plan_name).first()
+    if not maintplan:
+        logger.error("Maintenance plan '%s' does not exist. Available plans: %s"
+                     % (plan_name,
+                        ', '.join(MaintenancePlan.objects.values_list('name', flat=True))))
+        sys.exit(1)
+
+    release_name = str(reldata['name'])
+
+    try:
+        with transaction.atomic():
+            existing = Release.objects.filter(plan=maintplan,
+                                             name=release_name).first()
+            if existing:
+                if not args.update:
+                    logger.error("Release '%s' already exists for plan '%s' "
+                                 "(use --update to update it)" % (release_name, plan_name))
+                    sys.exit(1)
+                release = existing
+                release.start_date = reldata['start_date']
+                release.end_date = reldata['end_date']
+                release.save()
+                logger.info("Updated release '%s'" % release)
+            else:
+                release = Release.objects.create(
+                    plan=maintplan,
+                    name=release_name,
+                    start_date=reldata['start_date'],
+                    end_date=reldata['end_date'],
+                )
+                logger.info("Created release '%s'" % release)
+
+            for ms in milestones:
+                ms_name = str(ms['name'])
+                existing_ms = Milestone.objects.filter(release=release,
+                                                      name=ms_name).first()
+                if existing_ms:
+                    if not args.update:
+                        logger.error("Milestone '%s' already exists for release "
+                                     "'%s' (use --update to update it)"
+                                     % (ms_name, release))
+                        sys.exit(1)
+                    existing_ms.start_date = ms['start_date']
+                    existing_ms.end_date = ms['end_date']
+                    existing_ms.save()
+                    logger.info("Updated milestone '%s'" % existing_ms)
+                else:
+                    milestone = Milestone.objects.create(
+                        release=release,
+                        name=ms_name,
+                        start_date=ms['start_date'],
+                        end_date=ms['end_date'],
+                    )
+                    logger.info("Created milestone '%s'" % milestone)
+
+            if args.dry_run:
+                raise DryRunRollbackException
+    except DryRunRollbackException:
+        logger.info("Dry run; changes not saved")
+
+    sys.exit(0)
+
+
+class DryRunRollbackException(Exception):
+    pass
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1 (Apple Git-155)


