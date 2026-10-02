Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86AACA5FC4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:27:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9588.1790940429311944480
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 04:27:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=um9HnYzO;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CE361A10D7
	for <yocto-patches@lists.yoctoproject.org>; Fri,  2 Oct 2026 11:27:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D5787603DC
	for <yocto-patches@lists.yoctoproject.org>; Fri,  2 Oct 2026 11:27:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F9601032811F
	for <yocto-patches@lists.yoctoproject.org>; Fri,  2 Oct 2026 13:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790940422; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JT6T694ZeTF8agomGLQIyN7yQJ1eQfOymAsGJYFp9vc=;
	b=um9HnYzObtrx5myJUBab9/547E+Qj+mQ4mgyO74W1E33lJdVx3w/N/avs7Qs2Uc9JJyGW9
	5lbWDU47UZ/+R7HXGyD24NwQSYnKYk28hVJ7o9jGI0UKSbKpKhTN42IBlWcFu6dyc03FYI
	MC3Z4UmAX0VdzEFxc/ph0O/9rEHbdvqjpGPhmmKiwWOAeHFLTKG33l9J27N8fHnWSe4YKQ
	kWCgC4QKYQnxdo+huIVhH60jghKo/7F0nE5bYEO5NoSynRU5OIc7t4ml1zJjXbn/cNate2
	J/ycxpKjYl+J/zx8Te3Bw+doWqdQ4DSMGUYxeAn+JM1OxI0cCamawzhTtEmlsA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 13:27:01 +0200
Message-Id: <DLUBE7BM3OE8.1FN6C7FT9U310@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH]
 getproperties: Ignore meta-mingw if it doesn't exist
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261001104641.1596895-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20261001104641.1596895-1-richard.purdie@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 11:27:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4978

On Thu Oct 1, 2026 at 12:46 PM CEST, Richard Purdie via lists.yoctoproject.=
org wrote:
> We moved meta-mingw from check-layers to check-layers-nightly which means
> it can sometimes be in the config but not present. It is find to ignore
> if it isn't present.
>
> The wrynose layer will be removed earlier now and never be present.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---

Hi Richard,

Do we need to merge this also on wrynose branch?

https://autobuilder.yoctoproject.org/valkyrie/#/builders/85/builds/1441

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


