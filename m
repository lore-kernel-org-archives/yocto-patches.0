Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B04C25B5F
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.15794.1715182297773280796
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=s8tSQvsR;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.49, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a387fbc9so1150805966b.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182296; x=1715787096; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yv3YFthAGSyOwUcM+M6K7tq6nWQnA+hcVTTxvfgzc8w=;
        b=s8tSQvsRx5but1AIshPyj6hLI9TCQGUyGit3rjwluCdlapwiCN7TgicPbuA1nYY8iP
         8TB5PgR62AO/5sj0WklkO0V5nSQbcuQeIR5DPGCa1BwUpz7BUflYlMIBLjrPz3GlwQtq
         N9md6MpI/Q7O5HgMLi1ZH39kQo7ZzD+JJtmOLiIaYmUy0jav6Q4EMapW7z8BsRYuOURP
         MUjM31CEJDyh+x/ayh7yI5TUyU1/vcOhWDEHP60SvtVNpSy60pxjuR66yOLTaeCD0ipD
         JW1086FfBwSpd6xc//AxdjmfaQSwWfav0SqxpqktOaHoUKHRKgGMtNTKUAva47rlw1sI
         COxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182296; x=1715787096;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yv3YFthAGSyOwUcM+M6K7tq6nWQnA+hcVTTxvfgzc8w=;
        b=Wc6fowpfWJLqItfEz62BLhEIanGy5UpvS1iDlEHIq75KrTBoaxdqkovTuPn3R2Uyqr
         7ls/dQ91Vncc/snlyeeHoK6fv49jgC/XvdjAZkxZqp+1BsQiSntclCSHenHRPGxSVNQp
         7dh2PkGowJEho0eVF0ZtvQ6wY5xJ0W+Ejk/+x40ZvcTdKQbBZPUHeCqeLSeIEozwOibY
         T9RCeF/OiUAsNFPIFbk0f9DSR0QCfkzS3gOmGfSAGvyulh620tD9QeOEaD+aylNNhVpt
         piiScxjXwLPdUQxpNO7TmZnv71IYIrp2bnd4gg+nKoO8+4jiDyFSdtyzJa25ubj+ZHBd
         DF4w==
X-Gm-Message-State: AOJu0YwuXw6Ac+3aGyBxdHxkt2qoRnBkwvo2a31idoK+J4eYONhLIiqK
	T+MgYoYPdI74wlxTe7a7aHNmnW2F2j+lWmugql5vZcLQbADu6QJn8locRIFly+vl7SmZ9LObRtM
	l
X-Google-Smtp-Source: AGHT+IFALT+tvHCDCwoi3iKbTIL43uA19++VeM2juFoRkYdTKEon2oMYiHQsyF7MbwKMVTfZ6CM11g==
X-Received: by 2002:a17:907:1702:b0:a59:e3b8:ab8a with SMTP id a640c23a62f3a-a59fb94d745mr188748366b.20.1715182296102;
        Wed, 08 May 2024 08:31:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:35 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 02/12] patch-status: add README.md file
Date: Wed,  8 May 2024 17:31:17 +0200
Message-ID: <20240508153131.94270-3-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/93

From: Alex Feyerke <hello@alexfeyerke.com>

Add information on running locally for development, including generating test data from yocto-autobuilder-helper.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 README | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 00000000..ac2ee186
--- /dev/null
+++ b/README
@@ -0,0 +1,64 @@
+# yocto-metrics
+Yocto Project autobuilder gathered metrics, CVEs etc.
+
+## Local setup
+1. Clone repositories
+
+  Clone both the report and data repo:
+
+  ```sh
+  # clone yocto-autobuilder-helper
+  git clone git://git.yoctoproject.org/yocto-autobuilder-helper.git
+
+  # clone yocto-metrics
+  git clone git://git.yoctoproject.org/yocto-metrics
+  ```
+
+2. Generate chart data
+  At first we have to generate the necessary data for the charts.
+  For this we have to go the autobuilder repository and generate chart data.
+
+  Go to your local clone of the autobuilder repository
+  Then run the following to generate the data and save it in your local yocto-metrics/patch-status directory:
+
+  _Possibly you have to adapt your local path to yocto-metrics._
+  ```sh
+  cd yocto-autobuilder-helper
+  ./scripts/patchmetrics-generate-chartdata --json "../yocto-metrics/patch-status.json" --outputdir "../yocto-metrics/patch-status/"
+  ```
+
+3. Generate CVE report data
+  We need to generate CVE report data for each branch.
+  The following is an example showing data generated for the master branch.
+  You will need to run this for _every branch you need CVE data_ for.
+
+  📣 Replace master for other relevant branch names and 1709622082 for respective json file names.
+  The branch names and data are listed at the `yocto-metrics/cve-check` directory.
+
+  ```sh
+  ./scripts/cve-report.py "../yocto-metrics/cve-check/master/<TIMESTAMP>.json" > "../yocto-metrics/patch-status/cve-status-master.txt"
+  ```
+
+4. Copy cve-count-byday.json
+  This file is located where the index.html cannot find it. Adapting the path, breakes the live environment.
+  So we copy it to the `patch-status` folder:
+  ```sh
+  # Go to your local clone of the yocto-metrics repo
+  cd yocto-metrics
+
+  cp cve-count-byday.json patch-status/cve-count-byday.json
+  ```
+
+5. View charts
+  Once the chart data is created you can run the index.html file in the yocto-metrics repository as follows:
+
+  ```sh
+  # open the chart html file in your browser
+  open ./patch-status/index.html
+  ```
+
+  **Note:** If the index.html throws a CORS error you can run the file through the Python SimpleHTTPServer, for example with:
+
+  ```
+  python3 -m http.server
+  ```
-- 
2.39.3 (Apple Git-145)


