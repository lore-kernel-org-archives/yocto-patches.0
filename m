Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83509108B90C
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:01:29 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10945.1774008081785074563
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 05:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=xfFI7TVt;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=59ihOHwZ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 422571D001BA;
	Fri, 20 Mar 2026 08:01:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 08:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774008081;
	 x=1774094481; bh=Dfyh9wgPbg7pfVlHxdshOGeN3z5vkmuAda/YvEVkbOw=; b=
	xfFI7TVt20trxvwA/lFLE3fDbRDitYX2unmqJiUcQjfiQVU263+HhB8nr76cp9qk
	tJm92Vcm5L0nLkVp51PM81zUPPqWSEw1/vai8rs53eAyVqlBTvwofcnS6M1N4Srl
	50GgTeTxyQqy1F0CO9gStITWHDQA/hVFGYeKcSEQlz1Kcbdt/DOlzR8fHhTTQ79U
	ni2LNBU5B898LLPWHBdy5qfvNmUUJdFBBuyqdQc3/dJhLyCJAbiMh2rKuqd9bHzR
	lYaAoTLSTMH9gScYlgs+nVxGsiJVSr8++zKktEEmPVE974udMhGEukFVdjefulZm
	g2tljpo+FPZPwbSsMkgUuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774008081; x=
	1774094481; bh=Dfyh9wgPbg7pfVlHxdshOGeN3z5vkmuAda/YvEVkbOw=; b=5
	9ihOHwZYk3kkMEDhGgoRrCo/dS8o7e4tY9ZdBS9lY46bi5ys6eQeHpxlS/UUyeWn
	rHv7i0Wqaoe67iiTtwXxM63+XIJDFIveoxDeW74zIh9l9G2q03MqXC8emvmIb+80
	qymNPAkyT4D3e2XXzLGRx9r7UfwEG/mz6xuuoUR9yEtUM6RMZTvOoZdNDuhJKDET
	+vyGa4AQmRSnzcth8mc7Dak5DgvYrY5XYfypxcXvpmmPUBTKIZ7pxqLGRlwIhvXv
	2Jmq6c7E/jIpft8bNzSTUGPIdwR0O5aSWBqQNrzyXW4WZGrStO8LEYWkopX089+l
	V70hKK8MPRF1h9TOPYuJQ==
X-ME-Sender: <xms:EDe9aXsXvQyFe4Ijznm3NSSnN-TsrpIMllJu5ht8wMvqVQM-qAWRDw>
    <xme:EDe9aecgk3djm0Ri1e7OyZoP4SLAfe8WpwGrc4hho5BC6tu2430OgU4tprwEzvceS
    iR72xFScZJTtnlpIJpsVSdTmWzeCkG5VMOmE-_xl4jTh7wx3U-OebZS>
X-ME-Received: <xmr:EDe9aYaCcfSnho-zj-akCE0CY6epji4PALkmT2F3ApGGDYV-CX94djBRpN4tUmfgP8HyIuSckja-0-Y5HPLmr6mRYr1BFmQ>
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
X-ME-Proxy: <xmx:EDe9aRVA-741Td2fUG4lNYOO7MG9kVgw13Up-lc9zPnIQVRDzlW38w>
    <xmx:EDe9aaikrz9WUz2ePXdwcL3vnCB-lz4v8nk0alPSRac8CzMUdnO2cQ>
    <xmx:EDe9afX2LwQO6uVy0Agtya3jD4vpUA_N_LGPNGB0SwunAtZDp8Y8OA>
    <xmx:EDe9aRP3vNuT3Gm9VBn1tE_oAmeWmt7PnuIBzZAUbU6EOsmeEaDtvg>
    <xmx:ETe9afRg_fAlp5MHKJeTk4anG7Uy1ZZGfryBvxuVL_IFEa9UMgXl_dUL>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:01:20 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Fri, 20 Mar 2026 12:01:06 +0000
Subject: [PATCH pseudo 1/3] pseudo_setupenvp: Allocate space for new env
 vars if needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-some-fixes-v1-1-f5ca33dbf180@pbarker.dev>
References: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
In-Reply-To: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=ywFbXEiNuyFUWv7+OhaNhspFAldkhz7ETqG/IbsRovM=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTuNee7eStcWGzqm2ZnUfdVydZWi4Q8d6xeJDXJ3PedS
 1f4ptfxHaUsDGJcDLJiiiybe77ef9rryJsRcksBZg4rE8gQBi5OAZhIeT7Db/ad579Ma4r88P2f
 WPjvXg2FV8ai+zNN4z4Ir9r57e7nukWMDFfOyvK+zn36yl7i+ZMtYVdFuc/skulMXZhwwWqy+c9
 faiwA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 12:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3525

If LD_LIBRARY_PATH or LD_PRELOAD were not included in the existing
environment, we need to make space for them. Otherwise we have the
potential for a buffer overflow. It's pretty unlikely as it can only be
triggered when an application running under pseudo calls execve(),
posix_spawn() or posix_spawnp() with a cleaned environment that doesn't
include the above variables, but it's better to be safe than sorry.

Issue found by Claude Opus 4.6, but fix implemented by me.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 pseudo_util.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pseudo_util.c b/pseudo_util.c
index 671ab7fd9b81..4abcc155c286 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1141,6 +1141,14 @@ pseudo_setupenvp(char * const *envp) {
 		++env_count;
 	}
 
+	/* If LD_PRELOAD or LD_LIBRARY_PATH were not included in the existing
+	 * environment, we need to make space for them.
+	 */
+	if (!ld_preload)
+		env_count++;
+	if (!ld_library_path)
+		env_count++;
+
 	for (i = 0; pseudo_env[i].key; i++) {
 		size_pseudoenv++;
 	}

-- 
2.43.0


