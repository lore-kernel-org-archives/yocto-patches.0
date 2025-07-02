Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20764C83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 23:01:32 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.9821.1751497291697698989
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 16:01:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GXPlVImO;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5b8d13f73so459872685a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751497290; x=1752102090; darn=lists.yoctoproject.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1KJ0+AU+HVlB/HJ7QM10sLdLomw2PQOkWT7PQG67TQ=;
        b=GXPlVImO2VFZf72ZZyWY68TqfqHhxwEwwVTFFdUn8F2sskBwR0cu8d6DQcfSgffsIk
         s50vX1gWYqIIQq8f6IczfzrWRHX4G9Nbp/oVO10NmIHxPKVVTcsrM4h0D15dte9wngTJ
         6mC26jiLXUk+vi7OGIaq7xddOLQ6NrO1FgsQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497290; x=1752102090;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1KJ0+AU+HVlB/HJ7QM10sLdLomw2PQOkWT7PQG67TQ=;
        b=Xvgx1Rb8g0WFhvJ4Em/7KzGgCdYrdUlb5ZJosv0OWxQnhpPO4cfKNJryH2V70M9wWH
         jLG9W5DRGqYo53C5Yp+L80oIn7uN8z7sq1QOXuxxerPl8bMLEefzOzaIgCWuwxVdy5qe
         29Ss5MkI0iHEuQB4M110bltteSeUcDaHmpt4zzEINNFqyV9uuRaf02Vc/QGPWdRXR068
         ndmoY5voXyhQfGr5krQ5RQF6cpimO64C8KBBJOYVFrZx36MvSLZ4t2AzGy3iFeA1+j9N
         D/9U7TeROi6/sBzyj4WMvbknsFdLI3oElWcx8etOCWCyucYbvW3k3CQZ+nuXw+G6W1bF
         xqFg==
X-Gm-Message-State: AOJu0YzvwaFnYnp3Q/lk/6uDcG4908Btn2F2mVw9KLq3Fnquss6tK72y
	EAcWgZt8ALpkGhbokhCT/KZ3nYQYSIn6ySBd2Y2Q5LF0XIpXBmWwI6Qnjm9JIG2OcufdCoSMPTM
	oqji5
X-Gm-Gg: ASbGncsFcLCiX1dLLOU1dnCrTGjrnyKY4cHaOT2q7qxYqNcoqFuUWbAJC/gy6I5rtsp
	RUsEU3CQceZm/JuinQ++5c7ekAKMuWfIKMCvJKvvyhBoLMt/3XNIK5qVZS/htBrTND648qvWA4C
	BaZAsLUOpwZHTnYnIUIy0AIDj0kEekHhjhd/Yy21zF9RYX1Gy3r+ZF4cEjIWQrchVuyV9wfN9De
	lIXu7766deUuBkp8aRHga6Fc6PUiTZBHLynUjAO/OE89zMuAyrimhzZcja/WqShL8MyRnQvOrMp
	7pd6L85KuqICjh89b2F0Al1FpzmTyarRob1GFxIb2HLQwKvclE1P07zRnHtEcGaw6HnNVfnBSIL
	0j2kUE37iJOixzSxvjvu1
X-Google-Smtp-Source: AGHT+IE4umPPVhTMdowwmnUL9UHReDB3SSiaaMudgcchDpRadsgoj0XM8yQEfPh0e08UgDfNFk0tuA==
X-Received: by 2002:a05:620a:45a3:b0:7d4:4a26:4069 with SMTP id af79cd13be357-7d5c4703b76mr640705085a.12.1751497290415;
        Wed, 02 Jul 2025 16:01:30 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44316d85esm1008183585a.35.2025.07.02.16.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:01:29 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:01:05 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
cc: Gyorgy Sarvari <skandigraun@gmail.com>, 
    "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>, liuyd.fnst@fujitsu.com
Subject: =?GB2312?Q?Re=3A_=BB=D8=B8=B4=3A_=5Byocto-patches=5D_=5Bmeta-securi?=
 =?GB2312?Q?ty=5D=5BPATCH_1=2F2=5D_layer=3A_drop_styhead=2C_add?=
 =?GB2312?Q?_whinlatter?=
In-Reply-To: <OSRPR01MB11597653BE0E2BCC218C1FEEB9B40A@OSRPR01MB11597.jpnprd01.prod.outlook.com>
Message-ID: <3424ef93-a100-7519-3c15-e73476313597@konsulko.com>
References: <20250701100013.826-1-liuyd.fnst@fujitsu.com> <12b9c28d-4432-46bb-ac7f-5edda2b481c4@gmail.com> <OSRPR01MB11597653BE0E2BCC218C1FEEB9B40A@OSRPR01MB11597.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811583-1926228475-1751497059=:3525"
Content-ID: <ebd5eda5-ea64-b8fa-b8b1-ca1735104b59@spiteful.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 23:01:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1737

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1926228475-1751497059=:3525
Content-Type: text/plain; CHARSET=GB2312
Content-Transfer-Encoding: 8BIT
Content-ID: <00dffa00-5413-3d69-fa71-df2ca6762792@spiteful.org>

On Wed, 2 Jul 2025, Yiding Liu (Fujitsu) via lists.yoctoproject.org wrote:

> > -----�ʼ�ԭ��-----
> > ������: Gyorgy Sarvari <skandigraun@gmail.com>
> > ����ʱ��: 2025��7��2�� 16:24
> > �ռ���: yocto-patches@lists.yoctoproject.org
> > ����: Ma, Xinjian/�� �½� <maxj.fnst@fujitsu.com>; Liu, Yiding/�� �Ҷ�
> > <liuyd.fnst@fujitsu.com>
> > ����: Re: [yocto-patches] [meta-security][PATCH 1/2] layer: drop styhead, add
> > whinlatter
> >
> > On 7/1/25 12:00, Yiding Liu (Fujitsu) via lists.yoctoproject.org wrote:
> > > fix the issue:
> > > ERROR: Layer security is not compatible with the core layer which only
> > > supports these series: whinlatter (layer is compatible with styhead
> > > walnascar)
> > >
> > > Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> > > ---
> > >  conf/layer.conf                | 2 +-
> > >  meta-hardening/conf/layer.conf | 2 +-  meta-integrity/conf/layer.conf
> > > | 2 +-
> > >  meta-parsec/conf/layer.conf    | 2 +-
> > >  meta-tpm/conf/layer.conf       | 2 +-
> > >  5 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/conf/layer.conf b/conf/layer.conf index 84d40a1..7c8e403
> > > 100644
> > > --- a/conf/layer.conf
> > > +++ b/conf/layer.conf
> > > @@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
> > >  BBFILE_PATTERN_security = "^${LAYERDIR}/"
> > >  BBFILE_PRIORITY_security = "8"
> > >
> > > -LAYERSERIES_COMPAT_security = "styhead walnascar"
> > > +LAYERSERIES_COMPAT_security = "whinlatter walnascar"
> >
> > I'm not sure if this combination is valid, in case the layer fetches any source from
> > git - I believe it can be compatible with whinlatter, or with others.
>
>
> Thank you.
> But I don't know how to test it.
> Add new version and remove old version like others do.
>
> Then I will leave this patch as it is for now, and send a patch V2 for another 2/2 patch. Since We need it urgently

No need, I am working up a patch set that includes this, and Gyorgy is
correct; it makes no sense for the layers to say they support anything
other than whinlatter, as there are a lot recipes that will not be
backwards compatible due to the S/UNPACKDIR changes.

Scott


---1463811583-1926228475-1751497059=:3525--

