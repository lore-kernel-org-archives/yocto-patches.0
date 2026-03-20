Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96661108B90B
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:01:29 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10935.1774008082889020507
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 05:01:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=OaEKOSYt;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=S2HcZDch;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 492EE1D0019D;
	Fri, 20 Mar 2026 08:01:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 08:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774008082;
	 x=1774094482; bh=/R6gytKIS/FyfJOvT4/0yZe9/AixRMe4RtxRJx5eIzQ=; b=
	OaEKOSYt1XDHZ6s8775510TFZst093Fd/KvdSQo4Rt79Xan6GnpBEbu0bgWyb0Tl
	TzHIbJOhEkAEc8oUJxH88xw4MrDtpZnkD6/7/eOB2nx373CYPMKpKZ5QJG2Gb0Oy
	PAGN07QDR5fRPAmHF3tDlzkjQER+jCIdEVd/GndjbBK1G1QLocwrNu0RokvAP6/j
	a+YjAYX3ANZKhZFllnRL0EvrCRW/745JaTCghXWvZ0HklgMO/j9V/BvyWS5+juUr
	xm+PxnOEd5aubPTdHEv7GRZIAAvL1gt59tGMg7Uh5AdanzRqInZIXKWuRZjGgzFL
	mRifGQjzHc4HTRGcl+cMXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774008082; x=
	1774094482; bh=/R6gytKIS/FyfJOvT4/0yZe9/AixRMe4RtxRJx5eIzQ=; b=S
	2HcZDch8/cuZF4DUFsA9wwAdelhAv4+EX/HQlA5TGjwqQi+gURjvAEMnOZe09n77
	M5PTs8VMglXFJpEZnh6Uj9IS067GYmElAi2HMW3KNey/l+WpfuTYxl/plvF5MhGu
	Efk20GjWRoZF+GXayBGkHJW6g/ErOkBfrunKOCOmsRwXYexVPQ8fe7PY7uZVrNnw
	svF2MGALlYWomOXNUKB23PjdoCx/fv8beCCsqFm9IVoPgJ+h7vSpdQYnphOM3D90
	q3dKqyhiMJgQj1p64540GSwEg+gz5b3c+Rj+77fQq0APtvsc5GWIW2vbVYvBJ5nJ
	Z9xOqAZO716BWh+tGlnXQ==
X-ME-Sender: <xms:Eje9aXtehpIhC7xRM03vX-u8p15eR4ftLqQ6wLQgrLt1zbRWc_0yhQ>
    <xme:Eje9aedbELhzbX0QL9_gyI9ATMoUpz7GBKH55PTDQS600WvQN4d_YEfTrrx6QqnAZ
    ykEM7akIUzJfj3etnQ6_9ASWscTBx5qCgWXqMzpihj4p53oWREkAg>
X-ME-Received: <xmr:Eje9aYahxVBtBDpU2N6gY0HRP2TpIDOEnlPmNKgnJt8X-gqPCaIYOp9DpwJl1eutcRfNyuHT7XWtexwcDNu6BvBDt7L7LFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgv
    rhdruggvvheqnecuggftrfgrthhtvghrnheptdffvdffjeevhfelieegudfgieefleefue
    efffelvdehfeeviedtieeukefhleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghr
    khgvrhdruggvvhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrd
    ihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:Eje9aRVzpjYmLbRIhbCubFXTfsV8NYdAXfCFxS3KkLJ-9aurL4mcFw>
    <xmx:Eje9aahbZgeui38Zb2XdiU9QBVE9FEUtRM7eLxtiVCh-BdZioxRdyw>
    <xmx:Eje9afXhZeny5UZnQbu9VbK_0_SVSralIUZILFQhjY9H0ksm_GAH1g>
    <xmx:Eje9aRMG1IiiI6ip4A2ON36T9KN6yTGUMmzXEz3dutVFBtG6v_kdEQ>
    <xmx:Eje9afSXW0UwxeVMkxRDsW7sLyDcQTWylTNDW2_X52MA3pGDiGPnnKD7>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:01:21 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Fri, 20 Mar 2026 12:01:07 +0000
Subject: [PATCH pseudo 2/3] pseudo_setupenvp: Handle malloc failure safely
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-some-fixes-v1-2-f5ca33dbf180@pbarker.dev>
References: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
In-Reply-To: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=fvf3ncCT7+tSs4eTMu75Al5QeFhNssvt4ImEae2vbEo=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTuNefjDpvd+8W77/PLd7FfxFlM/qSsbzr0bKHRR7egx
 4uOhy3g7ChlYRDjYpAVU2TZ3PP1/tNeR96MkFsKMHNYmUCGMHBxCsBEwioY/vD1u7q1Ljj1Q4/l
 0+6HXSpXhYR0lm9Zpfv5zl7b1fcSyx8xMvTe8l0vFby0VarZSdPXVuZ+y6qJvTMYP0rK9kzMjlh
 azQsA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 12:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3526

If malloc() fails, don't try to write to a NULL pointer. Instead skip
the snprintf() call in the same way we do in other malloc error handling
in this function.

Issue found by Claude Opus 4.6, but fix implemented by me.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 pseudo_util.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 4abcc155c286..3a060275f115 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1201,9 +1201,10 @@ pseudo_setupenvp(char * const *envp) {
 			char *newenv = malloc(len);
 			if (!newenv) {
 				pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			} else {
+				snprintf(newenv, len, PRELINK_LIBRARIES "=%s", ld_preload);
+				new_envp[j++] = newenv;
 			}
-			snprintf(newenv, len, PRELINK_LIBRARIES "=%s", ld_preload);
-			new_envp[j++] = newenv;
 			free(ld_preload);
 		}
 	}
@@ -1229,9 +1230,10 @@ pseudo_setupenvp(char * const *envp) {
 			char *newenv = malloc(len);
 			if (!newenv) {
 				pseudo_diag("fatal: can't allocate new variable.\n");
+			} else {
+				snprintf(newenv, len, "%s=%s", pseudo_env[i].key, pseudo_env[i].value);
+				new_envp[j++] = newenv;
 			}
-			snprintf(newenv, len, "%s=%s", pseudo_env[i].key, pseudo_env[i].value);
-			new_envp[j++] = newenv;
 		}
 	}
 	new_envp[j++] = NULL;

-- 
2.43.0


