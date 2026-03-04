Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A27EB7EB2
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 08:46:12 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13862.1772613967643681856
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 00:46:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vvPa70e/;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 27EA81A2B56;
	Wed,  4 Mar 2026 08:46:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F35245FF5C;
	Wed,  4 Mar 2026 08:46:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E08F1036971B;
	Wed,  4 Mar 2026 09:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772613965; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K6iNOmy0QHB7Tt41dp1FKYtm7DfRepEDEeSCrSBpuKA=;
	b=vvPa70e/KZFQ5f/onngfe2x6yXF/ddqIwawrp0wjLvInoNSAwlOwMerTkJVbwfrdF437sd
	v0pQVhr2tOmDZwzIJm/bDYeZvf4t1bFaAN90Ta5Dl9JVgI84kvkmtI/9P6yd+IhPf/UZaB
	wrmoNijjs1bhCkxO1gI8Y1C/k78nEyAedrVx1c2oz3LNi3nHT8sOb7p9wX2BkGgTSO/iZm
	cYWBArZFQHt69NDKFvFSEI7hVh7c4xGq7uh6y8Gd4yRKrw5gwCnKbp/wrKE4E1FW5HN5x4
	NyqyZDL2mgWoqtxild7P7ZIFYxycTKsNpnv/+McMVOY7RbjEuLecn/pujj+38Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 09:46:04 +0100
Message-Id: <DGTV7HC4KYZ9.1S7G4MDL1X50X@bootlin.com>
Subject: Re: [yocto-autobuilder-helper][PATCH 0/2] scripts/run-docs-build:
 build using generated releases.json
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Antonin Godard"
 <antonin.godard@bootlin.com>, "Quentin Schulz" <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
In-Reply-To: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3327

On Wed Mar 4, 2026 at 9:40 AM CET, Antonin Godard wrote:
> WARNING: this depends on [1] being merged on yocto-docs.

I forgot the link...

[1]: https://lore.kernel.org/r/20260304-releases-json-v3-1-fdde0b9ba93b@boo=
tlin.com

