Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF8BC982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 08:31:13 +0000 (UTC)
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2512.1790152266120325416
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 01:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gd8dXXmR;
 spf=pass (domain: gmail.com, ip: 74.125.230.233, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso10298301cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 01:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790152265; cv=none;
        d=google.com; s=arc-20260327;
        b=DGPNdWEv8C1Ky07CGGoETDl8Ah7g9YFIXi1zIOU3Uyz+undvdqOLAj+PzmnPoBz7q+
         vm5VqYKZjD5iw5haogfpWwDGZ2clt7zqCkZFfAMH5RGjaUdIo9SbNAjJYKSewEb30d4z
         JucSaBVDfoTfqUg7LepZBqMj4OAbePnakFP+sBtNYhd42I2GaPc0lzwF/D92aQNtWnwd
         GTX3LoTARM6wO8h3uAH6vnZsnTGx04gNk9s7S2Aalzyn5fxN+1OOXxkP8eXWkHvN3uSg
         mjVDxRGt/QgRVfTcYxSLXe9FLGWbJtwkD60s7QyNBVWZs5bE0PUFF7cdVhfEOhDAbZl2
         oBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=njQxKMb2+He6OxdyZOqCC7BRgPkFuCeLgynX6pPTzqc=;
        fh=WFk6WqVLMumhhBiMgmEG6lAyoeJm2sRryqhUz7/ms2k=;
        b=XnwdCfxSnbBhMojXJ0ruaeEwHAdtzIvqwOwySSpZ81ynhxYZ9RMbrjwQPltx6n58bx
         9ETkxRzuY77jeOPunrjz5rdGPSoMGeuIpj1mfDWT/mlvVZqEtztf5WvZPFBIHqmETv3l
         B54phu+RSc5hMx7ucUCpPxIOXR/00erWxEKusuNtiwCaje4EbQbfPPk85Sz9oc2JOMaZ
         Ae7Cl5gFIth07r+aWzsZtDMhHPlhFAXa5xC0XPz1U+TyJaRwpTlCnwflTH6irzdcqVhn
         HQPGDHU8qAbWEjAVhlAIxSw5xTSikipNSro0yVXFSJhBy02nLBhhUAfaQ4/3QEvXOkcX
         B7iw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152265; x=1790757065; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njQxKMb2+He6OxdyZOqCC7BRgPkFuCeLgynX6pPTzqc=;
        b=gd8dXXmRQPJGTm/0QNQugF5tz5XGmVP8/pDIRtzN0eg7sfNUwiQmfpMoHKxTqpLUQv
         wxlct6VAeGE7mGZfZDiK/mVA1AMTRzETJnkEeKBuLzQbqwBSJ5ZXytcII6KhnJxLaiOR
         qORQvC7JrMSc1+pGCI8xgbKxN6+a5qTDGlS2iMddGHcoFkyfsivqelUquGM67ehxkKjj
         Q6wW3/lN6Q+yy78IhHA/gSfvpeThlRvJBca7b9BQq20gkFXyyOv+70cGxKhUjm4MNFsF
         qNB+uzYFpEWfBA4VqzDbSUTXVt7W59Dq5oTDGspUrN4C53eCqncSCTEq7QTwfO7DFLGl
         m/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152265; x=1790757065;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=njQxKMb2+He6OxdyZOqCC7BRgPkFuCeLgynX6pPTzqc=;
        b=ReiHdCp2hUDrwq3c0owUpzQafr160IT38iJUkGRMefgF1Quu4JQ60qnND6BAfhlfIT
         1MRY0MzsXmiXIBW46zjBPYwPUAE5KsZC7kWlom9DW84kRCDTT/nZ3PRTixfK/VM2UgT4
         bqBV243baApIdCi6tkaCynAJ49MmmEuIbJT4RXTtqTLsPFeznYEQUbzwduzWeT+CyOTM
         Wqftd6XOrlGNbKljFx0DrdJxF/oKmcbRMPMLGJjzEntH9tOaWS+3d9A9/OOX4cmvlLKq
         dWevzGIuLC2jqn71rcwIqWL9HeY91j4mUG8t/11fAP7iLBAoZ9l0kBtGhymSRlnH8ENu
         zL6A==
X-Gm-Message-State: AFuF++njHTHWg2OaxRRYVUPHYOUM+yhEsNGSTJ61C7Wpttw9Nm0biYi7
	vMyWENmZb1bD0fDBKJMX8/dw0nMaMmih4uYdvhBP5KyVKCg86EySjd1v4A91pMfiwcG3DQNmexG
	jrkMrjG+M+YVgnk7JNCIMtILmBTph8KE=
X-Gm-Gg: AYBFou13A1FN5yRDfufmEm22/9r5ine9gcah2TNyBKmVfksoDLkQCOyqB2RkgVbrkE/
	wcK35TQp3t2n8iZobFBMKwJ9GIsjulTalBtGz+HdzrsjJqzJUt7qdaQksMZOckfdvpHmvvqeoYe
	38KfK8kOlAvdNNG/814qALRh/K8iQbiKPZAmO7UNC8xdJTuuvsPyQgPzO1F1Cza4OYp/jmALnCj
	C64KAuSdCnBQozA6s4YAnbltxWrZSzYLzMVxKwJQaIGgYbrTOUQW/qvHRO7oE36e9RGuQe1LUEX
	6F2WRkK+Pk0fg70sITW6xF9fDEtUhYPLcM8+DpxDTMgtadkTvJh2Vj07LeAoxLTMZOhdgUhdpZA
	WwIaKHitf937vRZcLOyEP+3U5
X-Received: by 2002:a05:622a:1311:b0:532:18a0:491a with SMTP id
 d75a77b69052e-532eadb550emr31614041cf.60.1790152264982; Wed, 23 Sep 2026
 01:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
 <20260918120342.772566-2-daniel.turull@ericsson.com> <CANNYZj_dBU3QGcjOjfieN+BU2h-r+Tu-6eHeanGbO7MWshTjbA@mail.gmail.com>
 <3742d8808333cbbaad6a581d0569a5c72c0c060f.camel@ericsson.com>
In-Reply-To: <3742d8808333cbbaad6a581d0569a5c72c0c060f.camel@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Sep 2026 10:30:53 +0200
X-Gm-Features: AclHuK-fjxzyKAS7Zua3PQz8A6fT92lHOaDXz-6RDLr_izUQGhowX5AycvW2eSs
Message-ID: <CANNYZj89_YNSiewOPhmZjs5ad8-M7o8i44TxAsrkb+v5uu8qiQ@mail.gmail.com>
Subject: Re: [auh][PATCH 2/4] steps: skip duplicate changelog for
 shared-source variants
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="000000000000d925be065c224d11"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 08:31:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4935

--000000000000d925be065c224d11
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 08:23, Daniel Turull <daniel.turull@ericsson.com>
wrote:

> > I think this is not quite correct. Recipes in a group may all produce
> different changelogs, and in that case they should be all included. The
> idea is to remove proven duplicates, not just add the first changelog in a
> group.
> >
> Ok. I had the wrong assumption that all came from the same recipe. I'll
> send a
> v2 that checks and removes duplicates.
>

Recipe groups can all build from the same source tree, but they can also be
using entirely different sources, for example gstreamer plugins do. Groups
are determined by checking if recipes share a common include file.

Alex

--000000000000d925be065c224d11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 23 Sept 2026 at 08:23, Daniel Turull =
&lt;<a href=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>&gt; I think this is not quite correct. Recipes in a group may all produce=
 different changelogs, and in that case they should be all included. The id=
ea is to remove proven duplicates, not just add the first changelog in a gr=
oup.<br>
&gt; <br>
Ok. I had the wrong assumption that all came from the same recipe. I&#39;ll=
 send a<br>
v2 that checks and removes duplicates.<br></blockquote><div><br></div><div>=
Recipe groups can all build from the same source tree, but they can also be=
 using entirely different sources, for example gstreamer plugins do. Groups=
 are determined by checking if recipes share a common include file.</div><d=
iv><br></div><div>Alex</div></div></div>

--000000000000d925be065c224d11--

