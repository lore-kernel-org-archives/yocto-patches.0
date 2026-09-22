Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC0C98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 14:47:30 +0000 (UTC)
Received: from mail-ed2-f37.google.com (mail-ed2-f37.google.com [74.125.228.101])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12224.1790088448837977209
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 07:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QTmry918;
 spf=pass (domain: konsulko.com, ip: 74.125.228.101, mailfrom: scott.murray@konsulko.com)
Received: by mail-ed2-f37.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so6192027a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1790088447; x=1790693247; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Mc14ihATj0MWy25wsMeXBHBRfl4VSgU1GkQK5XirwY=;
        b=QTmry918/UCG6OOFUmOe0iBQTBEaEeYVN2HCudbwOPoVcKleUwCSyxXXm6ZrOixS84
         KhGX/4Oo0bbn4Wc/czy7EE15Om1Y27CZ1T9A9g5XMaikXrvft991ADPKX9EN2jXqP9yO
         VVbbRcOgbXkE9FBAhGwrG/ZAi6C82WoyjoBlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088447; x=1790693247;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Mc14ihATj0MWy25wsMeXBHBRfl4VSgU1GkQK5XirwY=;
        b=DqXF+u3dmWEAxfQIBU1pc+8dQk58RhQiHp5jJqBu0iMr6EapHeoLf1Z+nBOw2Zc0Dn
         eZjMqhWVd7rMMei8mSTivrgOJlc/LE7AyQcEwqVbCziITcb4i2LGFpx9IEnv2s4w/65k
         EwBX9IJZpSGMtD9WOiOKGu2UoNsoV08H/0lbLmedAaktoC1xW+cspP8Fx04/AoP6/KwB
         m0v9H9EwlDA6hGM/uP7hdHDcT6LB/f+boKHDy8WJ+JaGfxZQEjDFVmHBEHJrys0IfZ1y
         d+MBrkxiqpPZrYbCVGe6MTPr+/8lM5k650izuaP6vUyvbnbm7Kunb6c/goA/QFx3UR/d
         qmSg==
X-Gm-Message-State: AFuF++lifZutbHZ8Dnmykk8GR//NLFz4AFgXOQJlWMUiX4U4CfZ/A8Rb
	2DTmb254RujVljHxWYlB5st0Yq4B02rAZUabWbtfOnPM4vciQJ3btUB6lmf3HdHVQB5t5aK9aD8
	GwWqmmiw=
X-Gm-Gg: AYBFou0r4rrsLRViTI9ssxKWLlOmAZyWlT6iB4rODMW2v6IC8XcRCHhrWV44XtYvnnf
	5xCmZ/BCjRhLZmyGyJ1Qvnh7HFZLQwCmGF1eWNftvEpijw0FRyXDFuW8QHQFavILE/U3aNf3+CZ
	Ca3Zx9deXkDL9gqjZQq1mZMWtSZPKVKN/ypbMtE+7O3nTO0HeoklL6CjWqdaOJra1XEG90m/r8u
	oQD6OdlNcObNTEI6Y4m1KLu10s3Q/w9Tkhiln2EiDD2BtxJmGxgs61ZqopHXHfMbdNa9KRPFtYs
	EkeuAtv9UhX7Av2zpKzA0sX+laboMvYNUgGNjHWttViteoyRfugFjAFyEJkkXM8P3ASlhy7+rZ3
	OcCJ0Hctr21LhPWt5x4GsEzM8tj6Qu4yW/m+UoMgqSSU5BJD8gZWvb/eRUlaPlD1lkSsCq3Q0al
	81HlgtopRMO9uhv5U88q4te75LKny8aNiETfHHqLRSZj89Hqs/DPH5u0u0l2HYTZ9kYbQhxPuZG
	DNOvoJQFQNXm2uZczw74kU/QEBPP/io7YLz6BNut6k0+mJmTP23dlGvO2EB9rwZtJxPw1OO2/pn
	eXZesoieBDYsCa6cny8=
X-Received: by 2002:a17:907:72d3:b0:c26:19de:9ae3 with SMTP id a640c23a62f3a-c2a15826934mr1184423466b.34.1790088446710;
        Tue, 22 Sep 2026 07:47:26 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c2a6336sm107257666b.0.2026.09.22.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:47:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:47:24 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Sandeep J via lists.yoctoproject.org" <Sandeep.J=windriver.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH v2] README: fix broken
 URLs in meta-integrity and ccs-tools
In-Reply-To: <733662.1790055712090319579@lists.yoctoproject.org>
Message-ID: <63c86643-e12d-e325-6f96-50bcea6ca0eb@konsulko.com>
References: <20260625051816.1844262-1-Sandeep.J@windriver.com> <20260708060836.1340817-1-Sandeep.J@windriver.com> <733662.1790055712090319579@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 14:47:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4930

On Mon, 21 Sep 2026, Sandeep J via lists.yoctoproject.org wrote:

> Hi,
>
> Gentle ping on this patch. It has been waiting for review for some time.
>
> Could someone please take a look and provide feedback?

It's been in master branch since 08/28?

Scott

