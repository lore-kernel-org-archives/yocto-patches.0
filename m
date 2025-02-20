Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DE8C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 14:05:22 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.49799.1740060315097125360
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 06:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UFDOHNDm;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B51FC4428A;
	Thu, 20 Feb 2025 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740060313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1V4KYkypwaGBEwL3wKg2aNrq0DZcXhotJ8hxhYqcrAg=;
	b=UFDOHNDmTePbcyuk3PAXRNb9N/GLXz/i6NszwAMzLpHdHo7uR0aSCrFYFvRrEeqat0BuGH
	+s3GnfJHlhQJRgHvZ3F03GJ6AaPZD6oPzLeZ+iridwrsB05L2ieHRE3U8ZkhJ7BT8V9OML
	n9M0sIDdTekUcD6J8nmbM4QgvgxvLfOMJ8aLyeSQT9nKnbMgdNoL5iDw4hfKNePoaAtjvG
	FdZht7l8j166aRj+pzxmJPb+K9HfJpJ5ywkz6trdqgEIjVze/HyhDQlxBCvZ58ZnpAffvc
	OmERvlenuh7vapd7TCjnm4g+TnEiL/0Mdf4UnJVZ8ATJ0lvnPFbuQ+Rdpo2uIw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 20 Feb 2025 15:04:57 +0100
Subject: [yocto-autobuilder-helper PATCH] run-docs-build: add a custom
 fonts.conf to fix rsvg-convert errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-doc-fontsconfig-v1-1-fcd0834c9c66@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIg2t2cC/x3MQQqAIBBA0avIrBN00EVdJVqIjjYbDY0IxLsnL
 d/i/w6NKlODTXSo9HDjkif0IsCfLieSHKYBFVqFqGQoXsaS7+ZLjpykida41Wl0wcKsrkqR3/+
 4H2N8cDkDsmEAAAA=
X-Change-ID: 20250220-doc-fontsconfig-4f54a9a12ad5
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5771;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Vi5j1o3f/8lha5zFGKYcvkGo72oZCVaCU8fzSQy0xC0=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBntzaYgwmpseFeuAUBzzjQpHqI9D2sUFSmBBUrb
 5Rvk/BQ5RKJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ7c2mAAKCRDRgEFAKaOo
 NkILD/9XK6+AWjZ0yvdIn5yOcMB3eiQPjzcrHfQJS8Ca/WG/MBVZMg2b+NrApazGkd0CIsxctpY
 2Y0Ue0egrvNKEhumQnCkLHr+g5NfArvsdsaCtF/+PWl5V5GEmyoh8e+Rrr0Sx7KPdEKFKrNdevy
 t7jEUCEyS97Zv75wDb1FDHEa1KQ0xaTLKJYPKmym8YHTneDVa/uG9BIVN1J/hJ1+k4qgUFh5twS
 zmvZqNzPKK1cPPCeNXnr2O8juaWiWEOdMFsGPI9Q2n09kGiTfazwAHuUOtQd9HsyD9LjhNHmC1c
 wq/IwDuDWyM5kBp9vrktsqpU7YgEdSiXBKnyAbbLLU9CN70Jl8/Qvg6Fcyqs+haC769MjMg4oZn
 jL0JmDGT67jDLXGbb8Jh991x6nKB9B3nhTLGWQc4ZDgx3szQnNZeZ1FOoI1Pc1HVxCMjZ9ZZVHX
 UuzSiNtIAzYtnMbgC1s18epIL8FZ5rrBuY5NBZEzIkeDPrWB5uaFzW2Eh5iVED/FWbMQ/AzIr5g
 VL8eBeCNNAuMbPBVic8c4ESGhWbkacZOhGPR8zPz6i/7S1qHUAyH8qbtHGYyFh4khLYrds+Tdky
 M990E7MB4uCAFirk2CR7Ql2nQzWPiivgWZKKjAeVIT2dRsjr6XifUV7OImk//tpkZWpeubmXqdO
 lEBPVCwUZym6BNA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjedttdeiiedvkefhffeilefftdffvdehheetffehleefudejjeffieetvdetuedunecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdphihotghtohdrihhonecukfhppedvrgdtvdemkeegvdekmeehfhgtudemiegttddumeeivdektdemkedthedtmeekfedvvgemvdehkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemhehftgdumeeitgdtudemiedvkedtmeektdehtdemkeefvdgvmedvheekgedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhot
 hhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 14:05:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1100

rsvg-convert, which we use to convert SVG images to PDFs/PNGs, would
always print out the following error:

  Fontconfig error: Cannot load default config file: No such file: (null)

As a result some SVGs are oddly rendered because it doesn't find the
correct fonts.

This can be easily fixed by setting and exporting the FONTCONFIG_PATH
variable which must point to a directory containing a fonts.conf file.
Since we build on multiple distros, we may not always find this file in
/etc/fonts (installed there by default on many distros). Additionally,
we can also install custom fonts using tlmgr and use them thanks to that
file.

Add a custom fonts.conf that adds /texlive/texmf-dist/fonts to the list
of directories to look for fonts. This files is just based on the
original fonts.conf. Also add the nimbus15 package to the list of tlmgr
installed packages so that we make sure we always use the same font for
rendering images (assuming the SVG files use the "Nimbus Sans L" font).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Test build: https://autobuilder.yoctoproject.org/valkyrie/#/builders/34/builds/143
Note: Nimbus is the recommended font for docs images.
---
 scripts/docsfontconfig/fonts.conf | 100 ++++++++++++++++++++++++++++++++++++++
 scripts/run-docs-build            |   8 ++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/scripts/docsfontconfig/fonts.conf b/scripts/docsfontconfig/fonts.conf
new file mode 100644
index 0000000000000000000000000000000000000000..2de227a502bbe04b4f48d7f801aedb292c074c97
--- /dev/null
+++ b/scripts/docsfontconfig/fonts.conf
@@ -0,0 +1,100 @@
+<?xml version="1.0"?>
+<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
+<!-- This is a copy of the /etc/fonts/fonts.conf file to configure system font access -->
+<!-- Modified to include the texlive fonts -->
+<fontconfig>
+	<description>Fonts configuration file</description>
+
+<!-- Font directory list -->
+
+	<dir>/usr/share/fonts</dir>
+	<dir>/usr/local/share/fonts</dir>
+	<dir prefix="xdg">fonts</dir>
+
+	<!-- Custom directory with texlive fonts -->
+	<dir>/texlive/texmf-dist/fonts</dir>
+
+<!--
+  Accept deprecated 'mono' alias, replacing it with 'monospace'
+-->
+	<match target="pattern">
+		<test qual="any" name="family">
+			<string>mono</string>
+		</test>
+		<edit name="family" mode="assign" binding="same">
+			<string>monospace</string>
+		</edit>
+	</match>
+
+<!--
+  Accept alternate 'sans serif' spelling, replacing it with 'sans-serif'
+-->
+	<match target="pattern">
+		<test qual="any" name="family">
+			<string>sans serif</string>
+		</test>
+		<edit name="family" mode="assign" binding="same">
+			<string>sans-serif</string>
+		</edit>
+	</match>
+
+<!--
+  Accept deprecated 'sans' alias, replacing it with 'sans-serif'
+-->
+	<match target="pattern">
+		<test qual="any" name="family">
+			<string>sans</string>
+		</test>
+		<edit name="family" mode="assign" binding="same">
+			<string>sans-serif</string>
+		</edit>
+	</match>
+<!--
+  Accept alternate 'system ui' spelling, replacing it with 'system-ui'
+-->
+	<match target="pattern">
+		<test qual="any" name="family">
+			<string>system ui</string>
+		</test>
+		<edit name="family" mode="assign" binding="same">
+			<string>system-ui</string>
+		</edit>
+	</match>
+
+<!--
+  Ignore dpkg temporary files created in fonts directories
+-->
+	<selectfont>
+		<rejectfont>
+			<glob>*.dpkg-tmp</glob>
+		</rejectfont>
+	</selectfont>
+	<selectfont>
+		<rejectfont>
+			<glob>*.dpkg-new</glob>
+		</rejectfont>
+	</selectfont>
+
+<!--
+  Load local system customization file
+-->
+	<include ignore_missing="yes">conf.d</include>
+
+<!-- Font cache directory list -->
+
+	<cachedir>/var/cache/fontconfig</cachedir>
+	<cachedir prefix="xdg">fontconfig</cachedir>
+	<!-- the following element will be removed in the future -->
+	<cachedir>~/.fontconfig</cachedir>
+
+	<config>
+<!--
+  Rescan configuration every 30 seconds when FcFontSetList is called
+ -->
+		<rescan>
+			<int>30</int>
+		</rescan>
+	</config>
+
+</fontconfig>
+
diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 9945d6b6e15367a54c5725c7dfac636b9f48dbe4..a001fb219af56ad12a5aebb3d632ccc7c81648c9 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -71,12 +71,18 @@ if [ -e /srv/autobuilder/valkyrie.yocto.io/ ]; then
         zcat < install-tl-unx.tar.gz | tar xf -
         cd install-tl-*/
         ./install-tl --scheme=small --texdir=${textooldir} --no-interaction
-        PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex latexmk
+        PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex latexmk nimbus15
         popd
     fi
     PATH=$PATH:${textooldir}/bin/x86_64-linux
 fi
 
+# Provide our own fonts.conf path to make fonts installed with tlmgr available
+# system-wide. It will pick up the fonts.conf file in this directory.
+# This is then used by rsvg-convert to pick up the Nimbus font when converting
+# files.
+export FONTCONFIG_PATH="$scriptdir/docsfontconfig"
+
 # Getting the old docbook built docs from an archive. Not rebuilding them.
 docbookarchive_localpath=${sharedir}/cluster-downloads-cache/`basename ${docbookarchive_url}`
 if [ ! -e ${docbookarchive_localpath} ]; then

---
base-commit: abae49b0f62f6f2083dbb057a3b8ab947e14e1c5
change-id: 20250220-doc-fontsconfig-4f54a9a12ad5

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


