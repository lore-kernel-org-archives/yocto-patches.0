Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27FC98310
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 07:38:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2562.1790235480447605204
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Sep 2026 00:38:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=X8IWoOrz;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B1A71A0FF0;
	Thu, 24 Sep 2026 07:37:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC4995FB45;
	Thu, 24 Sep 2026 07:37:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C3F71032947A;
	Thu, 24 Sep 2026 09:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790235477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kWvDJMgeqanRaDd//n8fEmOg2+u/tvtTEim4UDZflgE=;
	b=X8IWoOrznEnE0IXYx+Mn2pP8PN2sfTUam7SVX5dW3v+PkpaTrCtQYEOxH2tGsteyIICQFc
	DzEL/fbovJH4Skt5BT3ZOaOnXh9y9CDvL9Zg50F+6eiSUfaNvPetwQdQmx1XDbAC06x0ql
	OvmFOt9/sR9gcALDByBH0crlULx3bFlE7chSBVSQbAF4rR9bjQFMTCyCWC2agmqwBTtY4U
	61z9sb3/P0VYR4po6AY7/wPMxNoATLcq/SQdL11qnpJHJgRaKujXMWXHQaf2QMlybn7AwJ
	vAN5lPGZRPp8O4+DUtG5mPeTSxu+q1CV+XrKBG38YXhxLtbmgQo5Cb99tJvp4g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 09:37:55 +0200
Message-Id: <DLNDIFQAG08K.2N6SOR4IPT7Z6@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][dunfell][PATCH]
 config.json: fix cvecheck iputils warning
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Yoann Congal" <yoann.congal@smile.fr>,
 <yocto-patches@lists.yoctoproject.org>
References: <20260923-fix-cvecheck-warning-fdunfell-v1-1-bd0c0b400f84@bootlin.com> <DLNCINQHU830.27H37P8U5X2QT@smile.fr>
In-Reply-To: <DLNCINQHU830.27H37P8U5X2QT@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 07:38:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4951

On Thu Sep 24, 2026 at 8:51 AM CEST, Yoann Congal wrote:
> On Wed Sep 23, 2026 at 5:41 PM CEST, Antonin Godard via lists.yoctoprojec=
t.org wrote:
>> On Yocto Dunfell, an EOL version of Yocto, we consistently have the
>> following warning showed during the metrics job:
>>
>>   WARNING: iputils-s20190709-r0 do_cve_check: iputils: Failed to compare
>>   s20190709 < 20250602 for CVE-2025-47268
>>
>> This is because upstream stopped adding the leading "s" to their
>> version. Since we can't patch Yocto dunfell anymore, as a workaround set
>> the version of iputils so that the comparison passes. This makes the
>> cvecheck class show the following warning instead, which is expected:
>>
>>   WARNING: iputils-20190709-r0 do_cve_check: Found unpatched CVE
>>   (CVE-2025-47268), for more information check
>>   /build/tmp/work/aarch64-poky-linux/iputils/20190709-r0/temp/cve.log
>>
>> Which isn't shown on the Autobuilder thanks to CVE_CHECK_SHOW_WARNINGS =
=3D
>> '0'.
>>
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>> Test build (not pushed to metrics repo):
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/103/builds/4111
>
> Hello,
>
> Thanks! (I had that on my todolist for the longest time but never got to
> it)
>
> Alternatively, since the metrics is the last thing we do actually
> maintain, we could actually fix the recipe (if the fix is non intrusive,
> obviously).
>
> FYI, dunfell had 2 recent fixes for the metrics job.

Ha, I didn't dare sending a patch for dunfell :) Well, the same fix (settin=
g PV to
"20190709") could be done in the recipe directly. If you consider that
non-invasive, I can send it today.

Antonin

