Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF16C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 09:12:22 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.19441.1740129134128810366
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 01:12:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JFXlnT1l;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so969972f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 01:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740129132; x=1740733932; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8czda245C2SnKjNa2gJPGiucqllsyqOlWZ7HsHxdAvQ=;
        b=JFXlnT1lT5LUvEXISNE3072J1YlorPXZpU8NVkjx1XDn7U2+M6H7bYyC3rmJNlcGoI
         xQujIXmsVz3dUNfL13KZ2ONtOosCfqBhEp2qLIKG7rUGmpDNjJXWtTx4Dq5UxaG5fEy+
         MNGnLefv1HWaC8JbfILFf6x3/WBqlQI8DX/D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129132; x=1740733932;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8czda245C2SnKjNa2gJPGiucqllsyqOlWZ7HsHxdAvQ=;
        b=LEvRAqNePbRMw7Y7D5RBcwbluzqt1amDygLIZywSvRwAkuIEcqaql2mRBBG1w3l7VL
         szwek2va7MV89PnJm3R7PQEM1O8ZmNbmUkGMC15p+FQ9WOydayshbLWtxcI/Cs/X3Jj+
         xrNImNMqCksGtkYuHFPykIVDyf+tVQ/67Sj9jyycnRedpgeQuYfyP4AtWNOIX2ykc0KC
         Z+XAsnLC4CreSakpDFbJ+REh2j6kvQKblJWmVQXYNd9D74c2svXJQtbINMMwsnXdA6yo
         aGzJ4rMFrm5IjGcukvgcnutwNP0sJk6SYuwH5Duf6CEYP9b9Ijq+scIoR+cML+v+E86z
         OqDQ==
X-Gm-Message-State: AOJu0YwPuv6dwo66yaaoPGdU4TLa5vbXt3v2/XURq8R/R6ihjMM9vGiZ
	WhJ8l/z2ZEVjyWHbsYg0iMAg9xOhvTWkReMLmzH4Va04LdBSqKgLT+4uygVqJij0v73ndKNtcUs
	L
X-Gm-Gg: ASbGnctjiVQmVJw5FIZXa4oq10NVYoN8lVzwvNoQ0QUchkGp0iDdl28uery4stL3IGQ
	+ucCmLrYJxfpx6t6llmJ38teigeNNJ2G1VRD3YsH7YWlSPjB4+cCYttDAK/v00Fon88+5HcVLNI
	SakjbktWuImCAFfMVxy/N3iebv2PrIv61mgl0nDWbeO4zkL0RXbSD6Vt+B/tV09gEI7Lr4ipKwg
	1H7K3f1tKd5CMB02TUhBQmnCnP9PHv+/T7vYfmBfKZ93DJ82eR3Vmv3sHUOf5ML6CiIy+GRIJg+
	3NcZDVJDpzDU5yGnRQLIZoJRIZgu9YoFm6GcBW2vuivXRvYb6Gf8r7o5E3Jq/J1H2URO3S+25nv
	DK797jlTahi6k
X-Google-Smtp-Source: AGHT+IG4qpS0UjAr96V5nt/nVQoFbDMtrbtYxjjw+mtWw6IcbgWuGQS3kTMT16E+sRz+DMYy38L1Cg==
X-Received: by 2002:a05:6000:144d:b0:38f:3073:708 with SMTP id ffacd0b85a97d-38f70773556mr1598115f8f.3.1740129131958;
        Fri, 21 Feb 2025 01:12:11 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46? ([2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8121sm22537228f8f.88.2025.02.21.01.12.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:12:11 -0800 (PST)
Message-ID: <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status
 in patch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 21 Feb 2025 09:12:10 +0000
In-Reply-To: <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: 
	<TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
	 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
	 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 09:12:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1112

On Fri, 2025-02-21 at 08:27 +0000, wangmy via lists.yoctoproject.org wrote:
> It's definitely the best thing to be able to do this
>=20
> But there are many patches with this problem, and it is uncertain
> what the purpose of the patch was at that time (many patches do not
> have commit information).
> In addition, most upstream have not been maintained or updated for a
> long time, so the feasibility of modifying them all seems not very
> high.
>=20
> It is best for the author of the patch to make the modifications.

That layer is struggling for maintainer time and the authors of the
patches have moved on to other things a long time ago. I therefore
don't think it will happen by the author or the layer maintainer.

We do really need to work out that information but it isn't an easy
job. This is why we now require it but these patches date from before
we did that. It will need someone to spend time on it.
Cheers,

Richard

