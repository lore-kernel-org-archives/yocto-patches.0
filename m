Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDCC0219B
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 00:01:42 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.3403.1739318495074423841
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 16:01:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I+20nxLk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395561ab71so12559465e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739318493; x=1739923293; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYJhlNJVUzOCNqZKZLBCxtCgomj6fCsV7UEiVSKZJa0=;
        b=I+20nxLkeK7v0L5QWJ4np7x0QiMY7eG3ToT4fIXyrmlle4+w37ReSU5h2+MWp9oHMQ
         MrDz0CXqI+CQDgiySTZ9mfyzns2ZcngE8Gc+MPpjbMGRvmLmtg4YfROMAYR+wn6r4FUD
         7+LGzfqc1FXCH98Icr4aLcH/GLApg7FbHyckk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318493; x=1739923293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYJhlNJVUzOCNqZKZLBCxtCgomj6fCsV7UEiVSKZJa0=;
        b=ALr7gz9AzC+DZE/EKMIdOFnkp7PjNvhpP2hbsvEqNPCqqoVKQSzZB6k7vzY8VtjKT6
         n/ySGsyTGHC3uZzo0jjYXkKNlHfAnUZKkzFnSDf1OmG1OYv/1gEZd60+y2at7Byac1jg
         s1sPuFaK0FfiyCzzH8NNEXSK7ARQnk3xS3r3+F7MrNqahw+m5DjrqC26On8rtMLliFu0
         S0yFRFNq4cUec0bUY3lao5Vpyvvm1071FQ9trlHy5m8spdG39YhT78IREO3zrRtEMZhX
         Z5j/avoF5e8ONFCJhAuyH17wu/Xg6pojRt2k3fAjydth97mvcu8+NCwLiTS5ScYzw6fS
         RsWA==
X-Gm-Message-State: AOJu0YxIGajzIgCVCsrZ4kjXbCJXibyW+Ay4IAzPtouZsogLPbEL575+
	lH4wvVn6+yZ8iJioGsf7QPvv6VTHUaLxZZwzRjlMxW+YZUa3NBU/WBSGLE8uZ08d/JgXYvcuz6H
	2
X-Gm-Gg: ASbGncs3gALT+TTq4TVXs+vQXQ5xcA0pvlgajYIg2Cp+G+v/EtiDYCzU95Ou63hbLLc
	8EuTxmid2vKXnOR33POjco4OZpRKrG4/eIDC2qViBlJa2ZZeXX//+wSTcRXsaMlvCw5mtCBkq6u
	oqCMe6t/pkb2l3QdzhoauKhWP4u6cDT7wH5YvuavfAgX/FcdnAHAdCjxvt05029WDPM6pSMg0ez
	pjKecsmS2Ii+uXqWm5sSIhFSs7USS0Uh8ZDZbpOCwxPoy4cjlTXxu3X47gpMHeyq4hL0QWpSnPH
	ftEcrbykD/E2aPvsDKamM0G6WKnmCPmVPH1+IYNHqQKeuTljVWy0DP6ji1MpCYN0KRVuf7/jKwA
	OIpa/
X-Google-Smtp-Source: AGHT+IEOg7JyQ3c0EM38+EZE6JFLRo/iQi7F9c0jT33RbWnvYUoJ6WmsUUyrbCl/zSFbX4uVAV4hRg==
X-Received: by 2002:a05:6000:400f:b0:38d:d299:7097 with SMTP id ffacd0b85a97d-38dea252032mr618789f8f.5.1739318492896;
        Tue, 11 Feb 2025 16:01:32 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:212f:365f:bded:806b? ([2001:8b0:aba:5f3c:212f:365f:bded:806b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06ad81sm2928075e9.20.2025.02.11.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:01:32 -0800 (PST)
Message-ID: <410d2fa497ea2b0bcf194559ad6eba60799a8928.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2 2/3]
 yocto_console_view: Keep known revision mappings
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Mathieu Dubois-Briand
	 <mathieu.dubois-briand@bootlin.com>
Date: Wed, 12 Feb 2025 00:01:29 +0000
In-Reply-To: <20250211-mathieu-console_view_colspan-v1-2-d94a8c55acf9@bootlin.com>
References: 
	<20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
	 <20250211-mathieu-console_view_colspan-v1-2-d94a8c55acf9@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 00:01:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1076

On Tue, 2025-02-11 at 15:48 +0100, Mathieu Dubois-Briand via lists.yoctopro=
ject.org wrote:
> The yp_build_revision property disappears from the build instance once
> the build is done. There is no reason for its value to change, so keep
> the last seen value in revision mapping. This will prevent finished
> builds to jump back to "Unresolved Revision".
>=20
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> =C2=A0.../src/views/ConsoleView/ConsoleView.tsx=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 +++-------------------
> =C2=A01 file changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/y=
octo_console_view/src/views/ConsoleView/ConsoleView.tsx
> index 973c26424233..93c51b340b17 100644
> --- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> +++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
> @@ -208,6 +208,9 @@ function selectChangeForBuild(build: Build, buildset:=
 Buildset,
> =C2=A0=C2=A0 return fakeChange
> =C2=A0}
> =C2=A0
> +const revMapping =3D new Map<int, string>();
> +const branchMapping =3D new Map<int, string>();
> +
> =C2=A0export const ConsoleView =3D observer(() =3D> {
> =C2=A0=C2=A0 const accessor =3D useDataAccessor([]);
> =C2=A0
> @@ -263,8 +266,6 @@ export const ConsoleView =3D observer(() =3D> {
> =C2=A0=C2=A0=C2=A0=C2=A0 builderIdsWithBuilds.add(build.builderid);
> =C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0 const revMapping =3D new Map<int, string>();
> -=C2=A0 const branchMapping =3D new Map<int, string>();
> =C2=A0=C2=A0 for (const build of buildsQuery.array) {
> =C2=A0=C2=A0=C2=A0=C2=A0 let change =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0 let {
> @@ -278,26 +279,6 @@ export const ConsoleView =3D observer(() =3D> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branchMapping[build.buildid] =3D bui=
ld.properties.yp_build_branch[0];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 if ((!revMapping[buildid] || !branchMapping[buildid])=
 && !build.complete_at) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build.getProperties().onChange =3D proper=
ties =3D> {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 change =3D false;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buildid =3D properties.endpoi=
nt.split('/')[1];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!revMapping[buildid]) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const rev =3D get=
BuildProperty(properties[0], 'yp_build_revision');
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rev !=3D null=
) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revMa=
pping[buildid] =3D rev;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chang=
e =3D true;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!branchMapping[buildid]) =
{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const branch =3D =
getBuildProperty(properties[0], 'yp_build_branch');
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (branch !=3D n=
ull) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branc=
hMapping[buildid] =3D branch;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chang=
e =3D true;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0 function getBuildProperty(properties, property) {

When you start a build, it gets "Unresolved Revision" and I think by
removing this code, it remains there even when the revision becomes
known. The code would have allowed it to move to the correct line in
the display. This therefore may fix one issue at the expense of
another...

Cheers,

Richard



