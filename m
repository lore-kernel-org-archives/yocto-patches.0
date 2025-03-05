Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD7BC282EC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.10285.1741170316234931360
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HT1w/UaN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso7132765e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170314; x=1741775114; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dBl+Lczy0ykZno+Bb0zuUOtvjwAH1xJf6Ky6+fPTac=;
        b=HT1w/UaNlKikHL+pFl0A6/uf43ouP96w2i18+FBiDe6mgTcoJY97xcxzScMDaPpKxK
         uS5L/sjN/YoVCgZDcEQC6ofFhgO831E55yJ377hdVdkUUGPC7mg9Nr3G1gLr3jXKPzV6
         zVQiXW0caS+ky2laY04PPuBtH79zqIotBAuR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170314; x=1741775114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dBl+Lczy0ykZno+Bb0zuUOtvjwAH1xJf6Ky6+fPTac=;
        b=p/MjjxXhOwjaIT321hjt4rjDBaiZOg0fI3UMbsWAUdrwBicl7NgUpeKOuXbtMv+w1m
         rvnS73QdrZvcrHUIzQvKdZWJFVkby5J1J+R4Jsw7SvFYxCaO2r7tim35CMQNzMWnMS7E
         UIFf9nWmO09w1uFqmrvUoI+Z59YsAVJsG/Rev5lBTNatW5t8+PvJBeqtsVvD8m++wwF2
         nvFM3v+4FOGzY05r649OsCTBFigwI7d3flDIVr7K3mjfpLp4pbNIOHoSA9d0GQ8NlzDv
         ezKx7BhcNYhWWPw+uSWG+saOpNfPDLc2lhySidTG8XAZ8THW7KZtxKnE9fZ58K7SFnZ0
         pvpw==
X-Gm-Message-State: AOJu0YwGlvU2rtpwCMfGr/NxHSZkAVFD2qbLvaL2Ly9Mv2f2kUTzl762
	C0f99j/fyH6exnSHt9zoo9LKaMOOjFttu+cE/Yqne1Nhzb4/Xn94k2ce3ShIR46D0/EKq2t65Xy
	i
X-Gm-Gg: ASbGnctwCc62qwuQBeXpUj1NV+zVIU37yahD2UFmCyzGZAIe3pJ0la2AiktIH2gUz8v
	9NVN7zTT1rnsCGqvkCKvjETPEkzZHqXHWdt2g7mzYArpqEfv8PuPFBXvyC6FfmmaiP7GievnJbn
	Ta8X5c5D87nHmR44VFiaKGvtdbm4AipYPTYLOIuRuo0ahKUDcNDlHRRZ3kJWV5K3EYu9l6+7okz
	eyhj8wlVQf3h34lptlexTIvN83QWIemy/LTyiQstzPEX1B+a7JXBqOP5opL367cXXbIlr1LaGcA
	cnXkeGR2JTvPC5gIYFUVxpJu1FjGbyb7CtpMitMxut66HEs9nYD6F3ALJRrxj/g4O7zoSSZhOw=
	=
X-Google-Smtp-Source: AGHT+IHT6cLtC33/N7ET0dyI5gX0fR+T/NoMSFlduc39DHNpsIZCdivB8262VvYU5yulwxMCr5AQIA==
X-Received: by 2002:a05:600c:468e:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43bd293f76cmr19728335e9.7.1741170313914;
        Wed, 05 Mar 2025 02:25:13 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [yocto-autobuilder-helper] [PATCH 06/11] scripts/layer-parser.py: remove EOL layers
Date: Wed,  5 Mar 2025 10:25:01 +0000
Message-ID: <20250305102506.2043524-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1149

From: Michael Halstead <mhalstead@linuxfoundation.org>

Remove caching and optimize to run on the autobuilder from scripts/run-dashboard-index

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/layer-parser.py | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/scripts/layer-parser.py b/scripts/layer-parser.py
index 246158d..e53a914 100755
--- a/scripts/layer-parser.py
+++ b/scripts/layer-parser.py
@@ -2,44 +2,32 @@
 
 import os
 import time
-import requests
 import json
+import urllib.request
 
 LAYER_API_URL = "https://layers.openembedded.org/layerindex/api/layers/?filter=yp_compatible_version__isnull:false&format=json"
 LAYERDATA = "layerdata.json"
-RELEASE_URL = "https://docs.yoctoproject.org/releases.json"
-RELEASEDATA = "releasedata.json"
+# RELEASE_URL = "https://docs.yoctoproject.org/releases.json"
+RELEASEDATA = "releases.json"
 
+with open(RELEASEDATA, "r") as file:
+    releases = json.load(file)
 
-def fetch_data(url, file_path, cache):
-    if os.path.isfile(file_path):
-        modification_time = os.path.getmtime(file_path)
-        time_difference = time.time() - modification_time
-    else:
-        time_difference = 1000000
-
-    # Re-download if the time difference is greater than cache value
-    if time_difference > cache:
-        response = requests.get(url)
-        if response.status_code == 200:
-            with open(file_path, "w") as file:
-                file.write(response.text)
-            return json.loads(response.text)
-    else:
-        with open(file_path, "r") as file:
-            return json.load(file)
+with urllib.request.urlopen(LAYER_API_URL) as response:
+    if response.getcode() == 200:
+        data = response.read().decode("utf-8")
+        layers = json.loads(data)
 
 
-layers = fetch_data(LAYER_API_URL, LAYERDATA, 600)
-releases = fetch_data(RELEASE_URL, RELEASEDATA, 600)
-
 # grab the recent release branches and add master, so we can ignore old branches
 active_releases = [
-    e["release_codename"].lower() for e in releases if e["series"] != "full"
+    e["release_codename"].lower() for e in releases if e["series"] == "current"
 ]
 active_releases.append("master")
 active_releases.append("main")
 
+print(active_releases)
+
 header = dict()
 header["layer"] = "Layer"
 header["branches"] = "Branches"
@@ -85,7 +73,7 @@ for layer in parsed_layers:
         parsed_layers[layer]["maintainers"] = "{} and {}".format(
             ", ".join(maintainers[:-1]), maintainers[-1]
         )
-sorted_parsed_layers = {"header": header} 
+sorted_parsed_layers = {"header": header}
 for layername in sorted(parsed_layers.keys()):
     sorted_parsed_layers[layername] = parsed_layers[layername]
 with open("parsed-layers.json", "w") as file:

