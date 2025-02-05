Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E0FC02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 15:17:58 +0000 (UTC)
Subject: Re: [meta-lts-mixins][scarthgap/rust] librsvg-native no longer building
To: yocto-patches@lists.yoctoproject.org
From: "Chris Laplante" <chris.laplante@agilent.com>
X-Originating-Location: Jamaica Plain, Massachusetts, US (148.5.72.184)
X-Originating-Platform: Windows Chrome 132
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 05 Feb 2025 07:17:50 -0800
References: <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
Message-ID: <12196.1738768670955878092@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="bAtvn1AUAUNXdse4sCNy"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 15:17:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1040

--bAtvn1AUAUNXdse4sCNy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

That did it, thanks!

I will submit the backport to poky for scarthgap.

Thanks,
Chris

--bAtvn1AUAUNXdse4sCNy
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>That did it, thanks!</div>
<div>&nbsp;</div>
<div>I will submit the backport to poky for scarthgap.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Chris</div>

--bAtvn1AUAUNXdse4sCNy--

