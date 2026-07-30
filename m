Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA1C531D0
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 05:07:36 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5001.1785388053027280349
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 22:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=J19F2GyW;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so20167895ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785388052; x=1785992852; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+xjASlzQwm+SZBrGUNvQnyzAL9ZeX2kvwuoaVXdF2w=;
        b=J19F2GyWV1SZD2qlpY05ZPXvUZFXokPKBHzunEMzBAb2VVUktSfBHQg6LTtsK26wNU
         YVfxjWdBzTlvuFwbGBq5SMUSojAOgZp/9DQpYIDvsUsRdvYQP0HRiGgG3iueT827Hfla
         99TkyvsX9wNgXfDU4DlDkErdWlHqQHKqDvfPmLjDq9khDZEyPYM/Kd724bIaFwLnwoTr
         0Ir9htXCJsetw3WrlK09l9qkck+msSI2pWLTEtjxa9AGaiDZpeOp+TjiIKcakrid5MZY
         5+Nx+uPhH4EAGDGKKqa0MsSjKq8eGGyDMzvTTfc5uD1JgM2tz1Xm9AK51Qj2IPpc5iIY
         dK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785388052; x=1785992852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+xjASlzQwm+SZBrGUNvQnyzAL9ZeX2kvwuoaVXdF2w=;
        b=EyDP4yvEtFY50Nr6hloIl58w3Ya8P1LQh1szEMnt1yZgpG5ZMuSjHvRLQKMf+TvbEa
         Dh4XuC/7dKJ/iCgdM7GIInTcf0ujZUCxhEcm5qvwVmtfTLi8YLfCMoGfuK4CHja2gXv0
         J0ciNbGhtA9o3DkSYhPgYeLDBXDm3ncH74pDKD+0pnbfaz5EsF2IO3YY0ChollZ/IL8F
         o7wrDWboDu5idUASsuuzzOLoitbPwEJcgdqOXBG8ykIoSIDbArwlgh/4Wm0SbXa+r7eL
         kdGbWhKqRMmqszl+Yqt1pTEHI8kEYEKZa3rEEtiDt0PGgdDVuUYrhPoD2Ms5N3hzmD7o
         QDsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5qQygiKkSWWUN7p/gZ22z2j2qDnL8+XLWY17Ng2EM1Y3u3VenqXfh77kWEa0zqYlVXdSRufon4Pbffo/j@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YywiQ1peoq0nh+zsDBY3NdZuXUPsVaunl6P/ysYzmpG5lWuqIaT
	RvBhi4KbxSbcviCm5Db5TBzfvL0WTygJQ+vgeyzi3eUcgdx6t2/Ju5jN
X-Gm-Gg: AR+sD12eUEzwGTWn5nYuiUkxUUoI7MeQNrbJ/50IVGSvVBGiFQ/3daET/0mjPPhzX8r
	umZwZD7V3hM0tiLOben0NPYzFmtzXUHsjRmD/2RUWB5owXN9vEuP8/xxb3dNRB1Oug5bpilKu2g
	y0O3N6krKkpF7cEMBV5VUCtqNZBZs7GTWdKomaT8jObPIMpe6zZ8OCZSMPoUxUKkUSFN7gjw41k
	axyj+U5M7UT4P8BnItchDGyg8z8Nu9Du0H1ORNIvz43GgKc+6ql5vaaDYvGsH3VxmnM/Obw+wVp
	1FIDZPPwl1oUvyi/eF09LRXIsu0EXCd5lWGR3kcFSHzdQAam1pUFhde//M0cwsPmeRmMMfi3JPI
	trwJClz4F0JxeZNywH1rrdzwZbwhxv6zjAhMVCmKvf80XUmd4YUaxMDJLgoP5xN78FnTAX8fGdj
	1h4a4oaUwRZUtOVNjiWxmsYGfloMgvV0TcKGyCE7g55rw2YiAZbOnoasDFOF0uGe4H4+6Hdjhn
X-Received: by 2002:a17:903:2f84:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2d035c4edf1mr12053215ad.12.1785388052202;
        Wed, 29 Jul 2026 22:07:32 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a1531dsm20088355ad.13.2026.07.29.22.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:07:31 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	yocto-patches@lists.yoctoproject.org
Cc: Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every pseudo fd, then drop one
Date: Thu, 30 Jul 2026 05:07:30 +0000
Message-ID: <20260730050730.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <15f732196c35cafae077a46b2ad4b88ae6191630.camel@linuxfoundation.org>
References: <15f732196c35cafae077a46b2ad4b88ae6191630.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 05:07:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4572

Hi Richard,

Yes, that's fine by me, thanks for folding it in and for redoing the
commit messages. I see the fd-protect patches on master with 1.9.10 on
top.

I've also read through the close_range respin on master-next. The clamp
and the OP_CLOSE_RANGE exemption match what I reproduced here.

Sorry the __open64_2 hunt cost you an afternoon. Happy to run the
close_range probe and the OE reproducer against current master-next and
report back if another data point would help.

I'll add a note to bug 16339 once the close_range side lands.

Cheers,
Baban

