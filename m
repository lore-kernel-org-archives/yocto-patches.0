Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A81F94CAB
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 20:12:43 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47761.1776802359255365818
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 13:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=E5vrcsNB;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ub3ATYne;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A00E7A00C0;
	Tue, 21 Apr 2026 16:12:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Apr 2026 16:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776802358; x=1776888758; bh=ZV
	eDcY/vTs44/TEPxURKYjUYs/gSf5CPI7hMLqaDE5E=; b=E5vrcsNBXpQ8XGX9O2
	QYEMgIAxoeq/52izh942/1M0Ja/NcgrDG+yBv6Chmc/68LGb3yyT2vE5GoKTtsyJ
	MQf+5bE5SbBsuqbmmtbFppPnkFDHNYs7pcdg4SxlzKIfpWEF2ZH7DQ/OUgvFOtQn
	SagYuZ113XWHU0OG1eiuLEoJXGsqsIaN0krQT7oijN+1aYtO8mZAbno84I+mQbmE
	3tsLRxROeG87AQo8/i4Kh6L3wz4epIyndmdEdje3gGYb4w6R2WCvOwVAyTgnK5de
	HuEMhvjqvcF/YEt+Qf8VSM/YqZtKxLP3GSW3QqeZLAqdYC/SyRqwXziTKKoEQCPz
	m9+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776802358; x=1776888758; bh=ZVeDcY/vTs44/TEPxURKYjUYs/gS
	f5CPI7hMLqaDE5E=; b=ub3ATYneh690k1HByAk9YpJL04O5V7ViMrcIn1BMHYIs
	jZC2JfTtgM8ryE71mwWSh7ZvSYFj1D+xPA/cZc/KkDxroyvueim7htPqdf3qLll/
	hmgoqeRXdjQzPtKVD9ZDthoEpmJO6WfC1pUYvFLPHkCawMqvqjxNlg93vCdFsoza
	fqRseWfagIpuoBWB1FwL35JgJne7gnsb1THeHs1mcIs7AX2v4dLuED3nq7So/ld1
	dwTxLbcSyjNsIs6xpcBP3fT8u6hpJ1EB7B18o9vLIQnn5WUARKihwNPO97isI+Ix
	wJr5RreRJQXPHO6ONIDGSdM9mR4TSlWfJXZL8SSBoQ==
X-ME-Sender: <xms:NdrnaeRkBzYXvbeAei8f3RSX9qGzXOnfviaYnHr37oiSMeAp9wljNQ>
    <xme:NdrnabPEzBGtLB2DgcYPoGxvJ6gra11qKql8NpHIaF28e21BwTSPJLJtkCKmF3y7T
    gaZB2kLck0TIfiPPXyc4Z63sCVFfozicdErYjVC3CwQ-F1r9MDwiX4>
X-ME-Received: <xmr:NdrnaZOaalDR4o1Pf6i-oYVvrbVBD4hdxphroaLq-dzXz1iIFf1Iv_SeXksXkaF2ZVhNgkciZicU32cMaRu8w6bgrx5L3qY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgruhhluceurghr
    khgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnheple
    ekgeevvedufeekgeefudeileekheeflefhfeejieeftdevudektedviedttdefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdphihotghtohhprhhojhgvtghtrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehp
    sggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehprghulhesphgsrghrkhgvrhdruggvvhdprhgtphhtthhopehtfiho
    vghrnhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvg
    hssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:NdrnaTtmkubexx148zZvxH5Tbandt_NGLSxNFccb5FFG2b_Ge5jnTQ>
    <xmx:NtrnabUE9IbL6jwlHerV7uekTkMIcM1psS8TH1DvYJWyAyG2lHIW3w>
    <xmx:NtrnaTsgjglDjpwpJylt9ebSlpGnf49chqZuhU0v5u-KA_4cOb2uVA>
    <xmx:NtrnafXErxC6D3kn45b2x-vyTvOB-Niyc3b5l0_E7u3ps75S5WAZwA>
    <xmx:NtrnabsS5sQRQQaae-rPU8F83o9DGT7DfhmIlRjTzwU3PHHuEb2kLycY>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 16:12:37 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Tue, 21 Apr 2026 21:12:32 +0100
Subject: [PATCH yocto-autobuilder-helper] config.json: Use new wicenv image
 type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wicenv-v1-1-17447e94d2f6@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAC/a52kC/yXMQQrCMBBA0auUWTvQhrQUryIuJuloR0pSJklVS
 u9u1OWHx98hsQonODc7KG+SJIYa3akBP1O4M8pUG0xrhtaaDp/iOWzYWxpHItd7O0DFq/JNXr/
 RBd7R54hUcnRFlokVZ15WVrj+ZSruwT5/v3AcH8TFlG+EAAAA
X-Change-ID: 20260421-wicenv-54a88aab5c46
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>, Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3550; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=rWcNfxwhzxCfNG4RV9/0o6qtSo6iA1ptrVCJGHwrIsI=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQ+v2UanOXC5hFY3d9wRWzzArujnbUq+63Pfd8y12xa/
 SZLr4+zO0pZGMS4GGTFFFk293y9/7TXkTcj5JYCzBxWJpAhDFycAjCRSaoMf6VWTDLf1T/z7Laz
 OupXnjWxyBfv/b7JrOLTx9fn2aQfLv3DyNCyooEvbt+lB4tmHM0T+RI5oUdmQtvlNPbXutVXO+c
 2yzEAAA==
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 20:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3753

After the recent addition of the wicenv image type in openembedded-core,
we can use this instead of manually specifying do_rootfs_wicenv as a
target when we want to create the wic .env file.

This fixes the race condition which has previously caused failures of
the wic builder - dependencies now are set correctly so that the .env
file is always populated before do_image_complete syncs files over to
${DEPLOY_DIR_IMAGE}.

Fixes: [YOCTO #16246]
Signed-off-by: Paul Barker <paul@pbarker.dev>
Cc: Trevor Woerner <twoerner@gmail.com>
---
This should be applied alongside "image_types_wic: Introduce wicenv
image type" in openembedded-core.
  https://lore.kernel.org/openembedded-core/20260421-wicenv-v1-1-75450eff8364@pbarker.dev/T/

Test run on autobuilder:
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/15/builds/3600
---
 config.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.json b/config.json
index 2db902c4dd27..bc0c03174ae4 100644
--- a/config.json
+++ b/config.json
@@ -1024,13 +1024,13 @@
         "wic" : {
             "BUILDINFO" : true,
             "extravars" : [
-                "IMAGE_FSTYPES += ' hddimg'",
+                "IMAGE_FSTYPES += ' hddimg wicenv'",
                 "MACHINE_FEATURES:append = ' efi'"
             ],
             "step1" : {
                 "MACHINE" : "qemux86",
                 "shortname" : "qemux86 wic",
-                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "BBTARGETS" : "core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
                 "extravars" : [
                      "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
                 ],
@@ -1043,7 +1043,7 @@
             "step2" : {
                 "MACHINE" : "genericx86",
                 "shortname" : "genericx86 wic",
-                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "BBTARGETS" : "core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
                 "extravars" : [
                      "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
                 ],
@@ -1056,7 +1056,7 @@
             "step3" : {
                 "MACHINE" : "qemux86-64",
                 "shortname" : "qemux86-64 wic",
-                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "BBTARGETS" : "core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
                 "extravars" : [
                      "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
                 ],
@@ -1069,7 +1069,7 @@
             "step4" : {
                 "MACHINE" : "genericx86-64",
                 "shortname" : "genericx86-64 wic",
-                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
+                "BBTARGETS" : "core-image-sato wic-native:do_addto_recipe_sysroot wic-tools",
                 "extravars" : [
                      "DEPENDS:append:pn-core-image-sato = ' parted-native cross-localedef-native'"
                 ],

---
base-commit: 0bba6f667fb614af7d172cf8990cdc429e6fd919
change-id: 20260421-wicenv-54a88aab5c46

Best regards,
--  
Paul Barker


