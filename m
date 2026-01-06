Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E676CDC19C
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:15:40 +0000 (UTC)
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89567.1767705332028359066
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Jan 2026 05:15:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=vWZ2kMm+;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=b0q/a0k8;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 58AA61D000B7;
	Tue,  6 Jan 2026 08:15:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 08:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767705331; x=1767791731; bh=aL
	J+ukIhZLh3ffIidovHejAL0d/1/Zkx6fTyj2P1Fq0=; b=vWZ2kMm+XhSgXr9Qpz
	MtJNUQAZIBMm8JvaXUFUKiWW4cvgkwXkkUxxulxKgqPMdQkiNRxHr1U5NO9XceEN
	WfgLAltYum3l7AOBh0mteFoCP7PmoP8YWz+1p0/GlrEABSYzCFQMo6DWfCmvgfjo
	yHih4+aeBsf95npqgZipazxIWlChVvQXJ8BY2dG0ysMFeGuuuKiod50oYBGClg1N
	uHpRdnUb64v6SYyl1eIfdOrk4YoiBgdPcIdXTz7dnzJm9KNpsv+B3+x2v6Xu9/CO
	MimNmKmspR/ioT6HK+d/r5D57EX2X7c0OraaDxNBT9yFiXJhktfbrtYOxgkC1DPb
	Id1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767705331; x=1767791731; bh=aLJ+ukIhZLh3ffIidovHejAL0d/1
	/Zkx6fTyj2P1Fq0=; b=b0q/a0k8jgPPYvGGpBabGzRX99bqsVQZOUeTQYab0+m2
	Go9X1WE79IUOJm8lAfhZHwpm+sbKo0Jjo7D3iUTfB9NpN9MDgy6PhU/rlNb+e1IE
	HKNLnB0e1pXjt98tV7h+3vUVYkxfQjCESz4UOqh6FnunPMINhyTAlVzB0ZdwItkL
	tq9M/QpwVyCAnwHhr2z+FFzE2msvuLbVnJH1QY3hBUqHYIvsGpBPJtXasTwhJ1lb
	wHIl7D4OIMujEfbeoe7lEAMR/sn8k3ghBhC6R1NFC8hQxls1prUjOUh3vjeiiLRx
	DBphAMHXX8QtEfo+DunBGV+M3lDOqiUbgRSgS2Kvow==
X-ME-Sender: <xms:8gpdabhD2-LP5GuHVc44XydVfKPB0j4W2W0je7WnVKTWT4DPyO5BNg>
    <xme:8gpdaeDEZmxBxKtDD4V0Sp59YIAfXPUcJ9HM57N0eAMYSChBTr2n37DBIqdijVJR4
    QnnzFQet9bdCFdbUDi09CFRlwfgnYy-sIVbIARzr_fTu8R9Ir7jWpM>
X-ME-Received: <xmr:8gpdaYsJbG9BnR7m19ZQFUyoOZHUR11akKBbUoq13HB5tzaroSDVvtf7eQjF0g7geYlrieB7R-T62NhfDYzyPg3seCK__Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhephfetuefgveevvedvveegfffgffethedvjeefle
    fhlefhtddvjedvffegtdeludfhnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgruhhlsehpsggrrhhkvghrrdguvghvpdhrtghpth
    htohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtght
    rdhorhhg
X-ME-Proxy: <xmx:8gpdaTY7kf95hBocV5DO8dH5TtAMNi38WTHcr6oaQo5ubMqY6ibcFQ>
    <xmx:8gpdabU3l584THQnXNUaX-HOsK1unTpfA905fI9o0SKvW_7TEkKkuA>
    <xmx:8gpdaX5B470tPxh5n2oKmn7sblMcWwF2HhTE3gU8nLu2-lD8uicY0w>
    <xmx:8gpdaWjJVoaKhSG-4Lpv5NW7SXYgePdkx9vSq5L5tGQL92QWe5ydag>
    <xmx:8wpdaYF-NMFsMEhiXx-nnZVW_gurIkp5w8nZvEzhWITYN-GZvxmhXMA2>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 08:15:29 -0500 (EST)
From: Paul Barker <paul@pbarker.dev>
Date: Tue, 06 Jan 2026 13:15:14 +0000
Subject: [PATCH yocto-autobuilder-helper whinlatter] getproperties: Ignore
 meta-riscv for nightly-check-layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-riscv-whinlatter-v1-1-cb4210f7b674@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAOEKXWkC/0WMywqDMBAAfyXsuQtRqtj+Sukhj7VZCIlsom0R/
 93QS48DM7NDIWEqcFc7CG1cOKcG3UWBCya9CNk3hl73o+70iMLFbfgOnKKplQSn23SdNVnyg4W
 WLUIzf37LB3yzqxnNWrNdOfqmB4oLifoP4HkcJ2m89T6HAAAA
X-Change-ID: 20260106-riscv-whinlatter-8984f0ebed5b
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=c9eR6sXMkqzyRHr+wzUpwD0YWrgjiIpSnuan7YW/iew=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTGcn3MvXbVeHPTK/W30taNjw0jyyac937+r1OOJXjOy
 +UpCdPDO0pZGMS4GGTFFFk293y9/7TXkTcj5JYCzBxWJpAhDFycAjCR5n2MDPMX6Hmq1x/NXm59
 /vdJ2YnyVadtJBeW272fdS991nbWo/MZGb6uMNjbd8LFRsZtxZvYLerfrkrqCOj3KgWsKNwg+Xr
 hAiYA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 13:15:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2905

We only test meta-riscv on the master branch at the moment.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
Tested on autobuilder:
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/85/builds/901

This build still failed due to issues in meta-intel, but it got past the
"Load build revisions" step where it was previously failing.
---
 scripts/getproperties.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 39930c55d8ac..90ca1ef45d1d 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -56,7 +56,7 @@ for repo in sorted(repos.keys()):
     if not os.path.exists(layerpath):
         # layer may not be used by the build and hence not moved into final position
         layerpath = builddir + '/repos/' + repo
-    if not os.path.exists(layerpath) and repo in ['meta-security']:
+    if not os.path.exists(layerpath) and repo in ['meta-security', 'meta-riscv']:
         # Repos is specified on the controller but not used in the helper config
         continue
     getrevs(jsonprops, layerpath, repo)

---
base-commit: 6f793956c9b43f7a74f5a22c86a93b744b21ada9
change-id: 20260106-riscv-whinlatter-8984f0ebed5b

Best regards,
-- 
Paul Barker


