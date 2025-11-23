Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF443CFA46B
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 17:15:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18588.1763918113970035273
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 09:15:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A8xMw2VH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47796a837c7so22560235e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763918111; x=1764522911; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LD5cTyx3P1MXC+1NQ8BY6CqUn1VA0UmqYcYSRtTjeN4=;
        b=A8xMw2VHTZ/Umyg3BRDA9i4tBpD1UFp7k7SxPSIzBgTUDw0tNEXom8m61AiLSxsw4A
         gYAxI1e7sRdhZ+n9XmI4Mn+0c3431oV09y1aYtPv8qYyOL/Nt07muxFBEK/TRQKzWyB5
         5dXHLqMeg7ulcmxLrkntqrkrN7cUF7rcK4lbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763918111; x=1764522911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD5cTyx3P1MXC+1NQ8BY6CqUn1VA0UmqYcYSRtTjeN4=;
        b=EiqN7pO1jsvKrB6LeZL08x0hUTzRBVyV4ex1xqynI/QT4LnR3T3A2bP6iVg2MJwtg4
         Ip3qC1ourPrcXOn2tzaCat+IokJdmmd8e3WxgIYFsDXtyIDppmTW0KbQy+lWghbqScTB
         FOL9iRSQi82HkF+6rpoWl1aIsOMg+jj/Bvbdgdt1opflGjCjlM/UDqclmzpVyjzPlFof
         Vfx7MCJ5NmbINt7vU/guALxaFP/14rQ4Rsg/udHgv1y0d/YjWo2mcchlgnubsa+oELt8
         owbBQImeZebdw3jaTZ7zNJcKhEe2YNErdcG7Xtcgpce61NKKvtPgO10gvXeiOInIsZJ4
         xLHA==
X-Gm-Message-State: AOJu0YzZIN4ZeJAmRfse5ZO/siZHzi0rUBT2WOiF1L/u9fwmK26Ue7Cl
	UIAbkWbCh6y7hLZWTNA95t4xbjRSe2dE4s8Iw9r6IjU2urYx/dFx+8KYUujCFWaDfCz0+8wy35T
	h6yIE
X-Gm-Gg: ASbGncv38oCwDTwWW2DJWcHNNMJ4NFVgp6U2Y1SZxeoo4HzB+l2wNvyKa09ar8+hu9j
	hO5WVVLDbLDLwtQ7K9pZUnphuWRg9jkQQHaTi54mJjnYettUp1c53JS9Hj+27MWzx8tjU6UXLX8
	S27K9tr4chlyygOLP9IU4fgy9Z7dQm7D6OnapJe/bcNAWdPZ9NXX4t9xE/JrubKA1dsXDhgfxl9
	6zPLa+gMQKUZo7HlxinZlL3zAN0CqnDTLPQ5HhAcEVXGyba9RVbmlZj9P7K35KWIm0KlztfO+Xq
	MQF8hNJ3THttQhXQqV5/RNfqxgpR9KBJ3VX579YNyT8goWHvJl9favKONi5FljmzcpLAUdGnu8/
	nXTfeYmlBsTgkyL1lYHRGTrsiQnc5kQvPe98DKt+XMQXI9Qgoldy3ZncvvpywQmERUM7YPefcB9
	PNOD9CwItIrUa5befvi31vhUE0DmZnLWnwzaoRWQ==
X-Google-Smtp-Source: AGHT+IEk16AG1pOlthO7MH7XLV4sHaAJ2pUMlTN7C5mh8Fd4bHK/7gZGkLpaToapq10VZAF06Dsijg==
X-Received: by 2002:a05:600c:3b09:b0:477:a3f9:fda5 with SMTP id 5b1f17b1804b1-477c016e425mr69135685e9.9.1763918111450;
        Sun, 23 Nov 2025 09:15:11 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:775c:23a4:f31e:9be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226c2asm151360775e9.10.2025.11.23.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 09:15:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [yocto-autobuilder-helper] [PATCH] Fix requests to git.yoctoproject.org triggering Anubis
Date: Sun, 23 Nov 2025 17:15:08 +0000
Message-ID: <20251123171508.124628-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 17:15:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2655

From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Bot requests to git.yoctoproject.org are triggering the newest version
of Anubis. Work around it by sending a proper user-agent and setting
the Accept header.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/yocto-supported-distros | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index e70943d..11b05b7 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -42,19 +42,23 @@ import argparse
 import json
 import os
 import re
-import urllib.request
 import sys
 import subprocess
 import tempfile
 
 from pathlib import Path
 from typing import List, Dict, Set
-from urllib.error import HTTPError
 
+from urllib.error import HTTPError
+from urllib.request import Request, urlopen
 
 CONFIG_REMOTE_URL = "https://git.yoctoproject.org/yocto-autobuilder2/plain/config.py"
 AUTOBUILDER_WORKERS_ENDPOINT = "https://autobuilder.yoctoproject.org/valkyrie/api/v2/workers"
 
+REQ_HEADERS = {
+    "User-Agent": "yocto-autobuilder-helper (git://git.yoctoproject.org/yocto-autobuilder-helper)",
+    "Accept": "*/*",
+}
 
 INPUT_REGEXES = {
     "alma": {
@@ -321,8 +325,10 @@ def _filter_inactive_workers(possible_workers: List[str]) -> List[str]:
     _possible_workers = []
     workers_ab = []
 
+    req = Request(AUTOBUILDER_WORKERS_ENDPOINT, headers=REQ_HEADERS)
+
     try:
-        with urllib.request.urlopen(AUTOBUILDER_WORKERS_ENDPOINT) as r:
+        with urlopen(req) as r:
             workers_ab = json.load(r).get("workers")
     except (HTTPError, AttributeError) as e:
         print(f"WARNING: Error when trying to fetch the worker statuses from {AUTOBUILDER_WORKERS_ENDPOINT}:")
@@ -354,8 +360,9 @@ def main():
         exit(1)
 
     if args.config_from_web:
+        req = Request(CONFIG_REMOTE_URL, headers=REQ_HEADERS)
         try:
-            with urllib.request.urlopen(CONFIG_REMOTE_URL) as r:
+            with urlopen(req) as r:
                 with tempfile.TemporaryDirectory() as tempdir:
                     with open(Path(tempdir) / "config.py", "wb") as conf:
                         conf.write(r.read())

