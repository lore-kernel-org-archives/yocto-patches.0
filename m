Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17430.1795526108151064459
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 05:15:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fzNvGp8G;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ED462C2C648
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8516B601E1
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3CC311E69951;
	Tue, 24 Nov 2026 14:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795526101; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8pyQtrf7yCiviEcYu9RQtRZvOt2pqY75FInzdlluXk8=;
	b=fzNvGp8Gc9vjzpeZbC7NXzLjI3ghU/jKUQNuZFTU76+vRnC5sSkp+B4jmIlV+IFiGLeojg
	DUhAMhpSMJjn2Twg5YfJIfP/zhe0E3yDzTqE3jAyDlwzIJtWnmw2jeIArMYPo6hKvLqvHZ
	/YsNXb3EzxMIlqHj27QE33W4jE7dcwII2CPb54nFWZwOc2gaHV+EyzecP/qGsmUvFTnjxa
	GEMd0aG3Q1FPq24oSYIR9L1ocQ+TW8U2MEZEijQRjvm9lJ74ry74B89XDm/rQ17c+IXUkd
	8WJ4iSrUKuB+1yaxuGT/8NZom1JDF55u/5htIRVJyVEDt9lHQ9HUwxN/YqGKzA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Nov 2026 14:14:38 +0100
Subject: [yocto-autobuilder-helper][PATCH 4/4] scripts/run-docs-build:
 export bitbake/oecore repository paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-docs-build-oecore-functions-v1-4-ce9f3c4fbad4@bootlin.com>
References: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
In-Reply-To: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=982;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=i+qoB0J1p+9EhzYzBShr1JefAqbgGbH4U1ZCe0b/oCQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBY29DSUTT9gvUqZhvVfIyeyYlADUjBnmj/Al8
 CVL0CSdprmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawWNvQAKCRDRgEFAKaOo
 NixoD/9D5+Dcf7hqqwcxnZQ0774V+w8u7hNunfMHN4TN6yKX9PcnICQ1P515lqN747XzTNifIq5
 U5fmgiMPO5vnPaniX5mD/ZxB2FpqYsLJ70MEvU4S94wlTA7y/WBmCi+49UoogPKpxrkTbAhGF5p
 Mbf8NPL3Yebq0/TR99j6GVcL2vTETUt7ugpiKkQ92d3dqcHsB7VVpw6HMI9T+TefXp3g7c5Jxa6
 dNoFCzvy1LiWiW7VW/kH5X+L9Y9DhZAWwplJmFn+qaEW8TvjTWiESjyprYOr5a6s3+9Kqv6iLt3
 3Y5ymvEIkdTV/gEO4Rmfx2M6traXe3z/+EWDcDSkJDqKIb+w+I+6dlQRzbknTnXXkzw7CjBZutJ
 FuxNS9nCLtUEG9GdFH0O56BS8WLa9x54qMIn1rWGrnDXYrH1HKsbdhLEr1Nv4IilxqRGw7WRQVb
 zKkeD8tXI+oeKDx3Km6QGROuGQbBsNEVCEIYoyED+GvzkvOFMc7MQ2clrQaefuF9PzNtxyh9E/t
 v5ZoddiE6bmgyDtWggfogAhvxJrz8k1EplGheUzbo12q2UMcphhHWg70DiHlzp3oJCuxgD3MV8b
 ru3lwYcc+fLQw9d6VT0oBzHWPxMCh+3Mu0frI0PiM77UMig9g6OXvBlxHKk1tGcuTaAtP3cwCK6
 xDGwK7zvEO50W6A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5511

While the Autobuilder default layout is already the one expected by
yocto-docs to document docstrings, export the two environment read by
yocto-docs in case this layout changes in the future, so we won't forget
to update it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 36e0793..4a7e5be 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -195,6 +195,11 @@ git clean -ffdx
 
 export LATEXMKOPTS="-silent"
 
+# These two variables are used by yocto-docs to locate these two repositories
+# and document Python docstrings.
+export BITBAKE_REPO_PATH="$bbdocs/../"
+export OECORE_REPO_PATH="$oecore"
+
 function checkout_closest_ref() {
   # The purpose of this function is to take a ref from yocto-docs (ref=$1) and
   # checkout the closes possible ref on given (repo=$2).

-- 
2.56.0

