Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AE2E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 16:46:12 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.41669.1733503568394163755
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Dec 2024 08:46:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bFEj8Loo;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72C741C0003;
	Fri,  6 Dec 2024 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733503566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mgdqHEZue5XW/wOwcStZLI30Y6z4E5QfJ/fII294uc=;
	b=bFEj8Loof1F4DoGEcOD4qZE4znmjNs7IvH6ZIj3VQPxqgUPEpg99l8pAgZiwAsOk9wFBc3
	AsX7/RUonJGCfWdYo7OMBexijV2uoYtlQUEuf+g8wA669YZeG8rLXyNCrVFIepL2VWJv9V
	b1xnUcRhnoyypX8KbMwjLXvZkQUR9uDS2R05Jp8Oi2ijHCxdRewu19tC4ypA044QKCbIUm
	oWXb6KR1HZ6ISA3phm73M+Msn+kAh42WT28B5IWnm1twUrqYQp2GcGx1Q9/H8wSy1RokrA
	NAjTXzWkYunjimQ7ZbArwAMNQbsmhlfDQDndTgGnZM/SfwxV/RVtNKOdpw4g1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 17:46:05 +0100
Message-Id: <D64RQ8AMASZD.2U075T85OMJMB@bootlin.com>
Cc: <thomas.petazzoni@bootlin.com>
Subject: Re: [yocto-patches] [PATCH] qemurunner: Fix stack trace generation
 in exception handler
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <180EA422A041EE15.19074@lists.yoctoproject.org>
In-Reply-To: <180EA422A041EE15.19074@lists.yoctoproject.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Dec 2024 16:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/865

On Fri Dec 6, 2024 at 5:42 PM CET, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> Qemurunner exception handling code currently formats the stack trace
> using traceback.format_exception(), with parameters introduced in python
> 3.10. This will fail on platforms with an older python version.
>
> Change this to the old parameter order, still supported in current
> python versions.
>
> https://docs.python.org/3/library/traceback.html#traceback.format_excepti=
on
>
> Fixes [YOCTO #15675]
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Sorry, sent to the wrong list...

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


