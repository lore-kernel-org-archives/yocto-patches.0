Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF0C021B6
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 11:09:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.20794.1740136145852944225
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 03:09:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YmHoe40Q;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC6C44321C;
	Fri, 21 Feb 2025 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740136144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+ggWkYe32CiC/YyVDVincZiq588vxDlgxizuN6DH60=;
	b=YmHoe40QePM2r1czuk+lhA68VwfmedXbXN/UWzVcEii20z2FafvNmtJF0LxSHUOo06zuZu
	iqmI9tDLBmSZKtoxsWg4ZbLKGfRsVWBFHt9a49DfiYZu5nHFUVviWitY9wU7JLFxbzz+Gb
	PrSXkZ51Zmim9peI5UQTyGDqpugIc1WAwtg/n9PZoHSjfHD6QH1cju0njJtLKt/lxzi0iV
	OeGvSc1VTgQctv3Vm7mhF0xJrJ4TievpJmCignqr0iP4Bi2by2oTV96HfZEC2qSrY9hMoK
	D66T2PlDZp9ujh0jJbNMOuQXCQObUakPLFp+4s0e/dlC6gAeYP3BlIbyx1u5pQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 21 Feb 2025 12:08:35 +0100
Subject: [PATCH yocto-autobuilder2 2/3] yocto_console_view: Override Force
 Build form CSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mbria-release_selector_bugs-v1-2-13d166ff0ca1@bootlin.com>
References: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
In-Reply-To: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740136143; l=1314;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=U9T7Sjao5DA18nf9tkSXncdYViit7BK3KC+j2/Z5sbQ=;
 b=iWepUSE4sm8WIpDrw4+GNw/le+KJddccAa09W/MgeEmzS6umF2dt0/E6TzPzaL90ofnisyEia
 EM6KTyW4lcVDhg6njzLuZr9RtL5eWeCcjZ+1nIzPR6GBtBgVm04wZuN
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtt
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 11:09:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1117

Compact a bit the force build window, to look like what we had on
buildbot 3.8.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.scss         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
index 7969b229706c..15dd3a61bcbd 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
@@ -47,3 +47,40 @@ tr.bb-console-table-first-row {
     padding: .2em;
   }
 }
+
+/* Modify the Force Build form to compact a bit everything. */
+div.form-group {
+  margin: 0;
+
+  div.col-sm-10 {
+    display: inline-block;
+    width: 80%;
+  };
+
+  label {
+    display: inline-block;
+    width: 20%;
+    font-weight: bold;
+    margin-bottom: 0;
+    top: .5em;
+  }
+
+  .control-label {
+    text-align: right;
+    float: left;
+  }
+
+  div.col-sm-10.col-sm-offset-2 {
+    width: 100%;
+    max-width: 100%;
+    label {
+      width: 80%;
+      float: right;
+      padding-left: 8px;
+    }
+  };
+
+  .row > div.col-sm-6 {
+    margin-bottom: 5px;
+  }
+};

-- 
2.39.5


