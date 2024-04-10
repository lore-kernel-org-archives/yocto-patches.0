Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.93])
 by mx.groups.io with SMTP id smtpd.web10.164520.1712752230057933385
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 05:30:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS+hE8wWe3IixXSz7epW3i1fa6bKi+DZE83BkJmBSfc=;
 b=JfOjkcd75onHTV60RKVLXBsb6eE7DXBQzpMj7FnFAfS88t31UeJmwhoruXmFIJUl+vXXamoOYVUKx8MWJuSIL2j+srajAVOT8i/PcNDk/zIwm1KrAb7O9hF938eQD1o9Y4eDFRdsiXiZMmRZKw9QxJLgmU2mTovZPyc4qtLUTPUoanMXzEuFzRMfYtH4+ZCYNR5ZB1+5R2T1AmPXH/AsAIr1aOzR0aCspczt0bDw9pMrJLXSjzYh5BW0kvXLUjjz4LzwDNd6lj94o2GEMXd86/Hvt72RRK8sfVqo50AGLqgA0ffK9y23tgzkyCcBYPm4hXYJbeUxViRVW3muP14SnA==
Message-ID: <1044c9e2-409e-4c6d-b0d5-95fbf27289dc@theobroma-systems.com>
Date: Wed, 10 Apr 2024 14:30:23 +0200
Subject: Re: [yocto-patches] [PATCH 1/2] README: Switch to yocto-patches mailing list
References: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org
Cc: openembedded-core@lists.openembedded.org, seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Richard,

On 4/10/24 11:29, Richard Purdie via lists.yoctoproject.org wrote:
> We're trying to align the various components so tweak pseudo to match our
> other projects a little more and use the yocto-patches mailing list for
> submissions.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   README | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/README b/README
> index 468cf66..425ee6e 100644
> --- a/README
> +++ b/README
> @@ -1,17 +1,9 @@
>   pseudo -- an analogue to sudo
>   
> -IMPORTANT NOTE:
> +The official home for pseudo's git repository is:
>   
> -As of this writing, the official home for pseudo's git repository has
> -changed to:
>   	git://git.yoctoproject.org/pseudo
>   

Maybe we could use https here?

https://git.yoctoproject.org/pseudo

for example?

> -The old site at:
> -	https://github.com/wrpseudo/pseudo
> -
> -is no longer the "real" master, although I'll probably try to keep it in
> -sync.
> -
>   OVERVIEW:
>   
>   The pseudo utility offers a way to run commands in a virtualized "root"
> @@ -88,7 +80,6 @@ available for other people to look at.
>   
>   CONTACT:
>   
> -Discussions and patches should be directed at the openembedded-core mailing
> -list at openembedded-core at lists.openembedded.org. More information at
> -https://www.openembedded.org/wiki/Mailing_lists. Bugs should be filed with
> -the Yocto project at https://bugzilla.yoctoproject.org/.
> +Patches should be directed at the yocto-patches mailing list at yocto-patches
> +at lists.yoctoproject.org.  Bugs should be filed with the Yocto project
> +at https://bugzilla.yoctoproject.org/.

Maybe we want to add a prefix here too so we can identify easily for 
which project this is for?

e.g. for meta-rockchip we have:

"""
git config format.subjectprefix "meta-rockchip] [PATCH"
"""

maybe we want

"""
git config format.subjectprefix "pseudo] [PATCH"
"""

?

Cheers,
Quentin
