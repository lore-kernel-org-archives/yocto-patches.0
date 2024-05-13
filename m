Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DCAC25B74
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:30 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.62669.1715612367710478458
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=fF2OMBoC;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.43, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a552c8cbaso491693166b.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612366; x=1716217166; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EhH7PZ2o0pmQrsAP433OuLq+9dfa+anm+PYgw8W2H1U=;
        b=fF2OMBoCITochHrXllWMwCeI3hOFEuRhqiPEzCIfSdDhNvfHpkhtKTmGKBCJfFIgEF
         e1RRkOuVe3c8hGpuRMfw5R16KFBEOi2+EGvmjpmrPV5C7jGjD183jfRbxOEqNbD6ft2j
         JDA5Y6K09tdUCHypD3tSbCbhPtel7Lm9dRQ+p4axobDvTIXBlmS2zdUjUm5t+l2otjIn
         R9tk+Utz1JlDr3Lbk/J4sYNv5eovrnDKUCyLAMu786VPju72ui8vwk0fGZNtaLzO56V8
         HygfYoPcuHVHReRq5U43gvGE2staDaBvucJk+IVbJZ/h+v5uXLY5vSwYsx/0pfDG99C+
         8X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612366; x=1716217166;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhH7PZ2o0pmQrsAP433OuLq+9dfa+anm+PYgw8W2H1U=;
        b=K+mVTwFdzUNkYbjyWHMJTv+HSqw1Fr+hbUNe/dMhdR00bL/36qU/RcgzPBxoH9hnGg
         zH84vqirsLSiwuMvIhP3GPACbODCmHrw3EJk0sy6jqC6P1+cx2rrB8BDbaUJCDmCwGmI
         m0TTsRUSN8lNZdbQq45g/SZ5kAp08FYiiaSLneOOKBEng2d2BktMGrNpQpochEUZkY8/
         lo7ovcLv/3YG8UrOh5QmAGhfRt/Jj7tF9obRDWg9dm+5RHG4Aui7FSppEQR2cosle0f0
         Wy8a8qvjuRy6RqgyQDPUn3xD7gUXior6nevNpJe02PAnsUC+KKo5sbW5fnXQaNX+DuAh
         09Nw==
X-Gm-Message-State: AOJu0YziAXZzq6PcEYom8aDOO1LqXQ/tiuGih+8wQe3f2r0Vh0sI7ilS
	/S6eyS6HCxC/hA+Ghb6JqakxxwA43K6dkP5WNXlBoxO62PhO2hkNH0GMjlDDpETkWOTN3MuBxWP
	v
X-Google-Smtp-Source: AGHT+IE4HkU4OMOOKcFWOl0vgMx5ncf0VfP0RnEiAQPViU9oM750YJV7IPbCPeCv/MyqF35h5C8Qbg==
X-Received: by 2002:a17:906:7f8a:b0:a59:b6a8:4d7a with SMTP id a640c23a62f3a-a5a2d5d3d22mr666513866b.43.1715612366140;
        Mon, 13 May 2024 07:59:26 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:26 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 02/12] patch-status: add README.md file
Date: Mon, 13 May 2024 16:58:51 +0200
Message-ID: <20240513145905.4167-3-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/122

From: Alex Feyerke <hello@alexfeyerke.com>

Add information on running locally for development, including generating test data from yocto-autobuilder-helper.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
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
2.44.0


