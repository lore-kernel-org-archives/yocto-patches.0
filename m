Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DAD0E3E3
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 19:17:53 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.4764.1729797463817942477
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Oct 2024 12:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mOrq91pF;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: gael.portay@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4fa7d3baso122966f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729797462; x=1730402262; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nPPb9/+700qOqJVVz+klavcei8g0nuug8KAU63itfDg=;
        b=mOrq91pF3hFAeowJEJgksm9uHsYfOIS0ZJRj7171lk2+XmBT3/19k4CsH07N2QquOc
         7ayMUrbqB+3nBmZN4l/LbRF2dcVCigRUWMqeRh9pgg1kW8F3HLTzo1Zt+Sw438TS0RIR
         x7vX3ihCBl1RbCI7UkN3jVyi500W0w/G/GtoQMtOcXoAZOYrrwasudVfAko/jEz9l3Nh
         t2SFBuv86U67HJTxyDU1EJKqSfRa3i12dep/c12DGkn4BhcDYZop6eV6mMjYhrEhRBL6
         0Sg4z91dUbT1ijh0A2jlkarj9jpPzrBimlchIRNPtzp8c8M/V5fD1t7HPtrKURB2CZu5
         +L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729797462; x=1730402262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPPb9/+700qOqJVVz+klavcei8g0nuug8KAU63itfDg=;
        b=smoKBEMZgV/VXZhLJjUT5PHWczCeviR65SqtSl7ryWu/aHSJbKStfwasJXa+n6ZUfB
         GOdygQySjk/QcH7rzOQ46DZGSfNAq5cLOBs/oXrBmjDP39732LalwZtmgiC/GihyU852
         GF4wA7QajI7LjKqSUls3b7OdWay4Vmch0FT2pvk0e0JtBvM0+qluzknWmo8OrpkTrwwh
         iSz1dcHuDcOKLnC0MgS8yEocvQx/nvj2sflLDEzmml3H0rmUHGXoFjhOxEmQ56NFrP0J
         Nwf7DRuAJEEbhzeA7tTVycBySVXcDzLKy1+/NUjdO1I1u0U+BdWsnb/WvwHUypJxQ6lR
         GtFg==
X-Gm-Message-State: AOJu0Yx3Kl2O+cR6/ZzyAJpOUOBMZYQX8AcmEFPmDk0p/0NMGr2vp2R2
	NTgXL1VUXN+BjhtDYNxiYbFpcFizQ3USx5Nd+EcMN5XWbOhx2wCZSs+6gJKdoxacH7b3H/TbgsX
	fYCF6iz5Syqjbc237tFykkXb5MboiQ7fR
X-Google-Smtp-Source: AGHT+IEDC9XLrlBgKcrnVwu/NJ/a0J372AtYabrT8toWFBdCDtmaQTzftu8JBpthrO285TdKvDKVyd0WZPeKrO0Jiso=
X-Received: by 2002:a05:6000:1547:b0:37d:50a3:f351 with SMTP id
 ffacd0b85a97d-37efcc61e49mr2621003f8f.0.1729797461649; Thu, 24 Oct 2024
 12:17:41 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay+rtone@gmail.com>
Date: Thu, 24 Oct 2024 21:17:30 +0200
Message-ID: <CAHs7_BbZg9x2T3ELKmGREYk0ht3jBpSBsGy7Ux1CX31k0xfKBw@mail.gmail.com>
Subject: post
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000003c318806253ddbd3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Oct 2024 19:17:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/744

--0000000000003c318806253ddbd3
Content-Type: text/plain; charset="UTF-8"



--0000000000003c318806253ddbd3
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--0000000000003c318806253ddbd3--

