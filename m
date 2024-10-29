Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB99D7494B
	for <webhook@archiver.kernel.org>; Tue, 29 Oct 2024 22:32:48 +0000 (UTC)
Received: from 4.mo584.mail-out.ovh.net (4.mo584.mail-out.ovh.net [178.32.98.131])
 by mx.groups.io with SMTP id smtpd.web11.297.1730237604470899419
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Oct 2024 14:33:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=fDTw+BZk;
 spf=softfail (domain: syslinbit.com, ip: 178.32.98.131, mailfrom: louis.rannou@syslinbit.com)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.148.103])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4XdNm25MLDz1RkG
	for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Oct 2024 21:33:22 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-thc2g (unknown [10.110.101.69])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1D4EE1FDBD;
	Tue, 29 Oct 2024 21:33:21 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.107])
	by ghost-submission-5b5ff79f4f-thc2g with ESMTPSA
	id vRvkHaFUIWehMAIA4SpeVQ
	(envelope-from <louis.rannou@syslinbit.com>); Tue, 29 Oct 2024 21:33:21 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S0014a14265f-122b-4f8d-9b62-d075f5ba4841,
                    C49D0803718654D6FFB59F9CA7D9CF2B2A9C5111) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
Message-ID: <6004347f-19fa-4d83-a73f-ba127ea9c2a4@syslinbit.com>
Date: Tue, 29 Oct 2024 22:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] dm-verity: set staging correctly in case basename has changed
To: yocto-patches@lists.yoctoproject.org
Cc: Louis Rannou <louis.rannou@non.se.com>
References: <20240520193347.2271954-1-louis.rannou@syslinbit.com>
From: "Louis Rannou" <louis.rannou@syslinbit.com>
In-Reply-To: <20240520193347.2271954-1-louis.rannou@syslinbit.com>
X-Ovh-Tracer-Id: 6098436847568477505
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepleettddvveekgeejtdefvefhteeftedvueetgeffgeegiefhgeffhfehkefgveetnecuffhomhgrihhnpeifkhhsrdhinhenucfkphepuddvjedrtddrtddruddpgeehrdekuddriedvrdelpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=STmvKM3jKAJAltdrWx+ns5UU1WxDoOLmv99ClAr/xKk=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1730237602; v=1;
 b=fDTw+BZkXHImfbAncTFf9lO4lklTGPzEgvoubuUKRjV5Es8gieCZdMky3TMbSoWzynKfe7ET
 mApe7ickHyXF2xNRjePMZ7UtFziEJujTSbR/fwPc0fFQwdoaC/m4C08xbRk8qi04v+SyNzaoOmk
 Geezm1UAi47lmxJJ2AhpIoIopfTvg2rxrtJ5M9+vyPfIenwd+hWszRM1DsOGS3RBTMY03Mqn8t8
 Imc4PNYS7jECC+oc0CxjlWf+mKvae0ol2AoX72QI1ilsQNl6j5RH+URiX4bPmgyoEHRFuWFpSHL
 xygHtPiFeum8CyIrxcJx+yBIty2KU0izs1xI2hA4Y1Lhw==
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Oct 2024 22:32:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/772

Hello,

Could you consider this patch which fix an issue in dm-verity ? Can I do 
anything for help ?

Regards,
Louis

On 20/05/2024 21:33, Louis Rannou wrote:
> From: Louis Rannou <louis.rannou@non.se.com>
> 
> Fix the verity class when the IMAGE_BASENAME has changed. Prefer DM_VERITY_IMAGE
> for staging env and wic fragment so it matchs what is used in the
> dm-verity-image-initramfs and the base wks systemd-bootdisk-dmverity.wks.in.
> 
> Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
> Signed-off-by: Louis Rannou <louis.rannou@syslinbit.com>
> ---
>   classes/dm-verity-img.bbclass | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
> index 7f79548..1a34b4e 100644
> --- a/classes/dm-verity-img.bbclass
> +++ b/classes/dm-verity-img.bbclass
> @@ -60,8 +60,8 @@ DEPENDS += "bc-native"
>   # convert it to some better format. Let's drop the first line (doesn't contain
>   # any useful info) and feed the rest to a script.
>   process_verity() {
> -    local ENV="${STAGING_VERITY_DIR}/${IMAGE_BASENAME}.$TYPE.verity.env"
> -    local WKS_INC="${STAGING_VERITY_DIR}/${IMAGE_BASENAME}.$TYPE.wks.in"
> +    local ENV="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.verity.env"
> +    local WKS_INC="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.wks.in"
>       rm -f $ENV
>   
>       # Each line contains a key and a value string delimited by ':'. Read the


