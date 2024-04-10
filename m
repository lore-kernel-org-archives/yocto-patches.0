Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.119])
 by mx.groups.io with SMTP id smtpd.web11.7882.1712770421804725487
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 10:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU3JD7fccP0JXid31IWjWrekzrwbgjzrV3sAAU36+ls=;
 b=bKY3Mo+ZDqBjBQJFqsbwElGPrnY9HqNcnh2BWgxX0Lifn4vnx1XcsOKm16IakP+4N4W1o4+Q8bDisSrJh3siQQBvo4HQ/UynKtqIeqEtGkb2a+sxGHKS3vRTNJVA/9dZs3zry46CdwtENWI7l7aRAPZJ91YwMchsJGg8iTZW38advyhNgMMvKixhc4xN+cd8oO/qY4MjgUr4d9DUEtKebnb5BOqRTMDO5wX4TZCU415iIMT8v9hgtDn2BegCAB88SKL+CeO/LPOKGrbMrTRwwpvkfSSlwIIzQe0GL2Vwh5753usvkfPFFrORwPiQOdpnChZpGVDib/fQ0VFleWCchw==
Message-ID: <33b55178-0779-4449-b5f8-dbca4b3a4195@theobroma-systems.com>
Date: Wed, 10 Apr 2024 19:33:32 +0200
Subject: Re: [yocto-patches] [PATCH] README: Further improve the information about sending patches
References: <20240410173012.2051694-1-richard.purdie@linuxfoundation.org>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240410173012.2051694-1-richard.purdie@linuxfoundation.org>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Richard,

On 4/10/24 19:30, Richard Purdie via lists.yoctoproject.org wrote:
> Add the git config commands needed to correctly/more easily send patches.
> 
> Also tweak the description and mention who the current nominal maintainers
> are.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Got sidetracked today and forgot to send a patch, thanks for doing this.

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
