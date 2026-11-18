Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10028.1794999359677645894
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 02:56:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AIAtiv03841125;
	Wed, 18 Nov 2026 04:55:45 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AIAtiAN003416;
	Wed, 18 Nov 2026 04:55:44 -0600
Message-ID: <0fabfef3-dbe6-4fe4-8f7e-d5f8ad47f27f@kernel.crashing.org>
Date: Wed, 18 Nov 2026 04:55:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [OE-core] [PATCH] pseudo: inherit upstream-stable-release-point
To: alex.kanavin@gmail.com, yoann.congal@smile.fr,
        yocto-patches@lists.yoctoproject.org
Cc: OE-core ML <openembedded-core@lists.openembedded.org>, mark.hatle@amd.com
References: <20261117164151.1362220-1-yoann.congal@smile.fr>
 <CANNYZj9Uj5v-Tb1TrA+TrxrdEyjO+qj25byZ0fWtUpiLHKH-DA@mail.gmail.com>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <CANNYZj9Uj5v-Tb1TrA+TrxrdEyjO+qj25byZ0fWtUpiLHKH-DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 10:56:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5467

While pseudo is heavily driven by Yocto Project (and OpenEmbedded) requirements, 
I'm not treating this as a YP/OE specific project.

When I say pseudo-1.9 has a stable API, I mean that.  The intention is that 
development happens in master.  Stable branches can have backports, as 
required/requested by contributors, but these backports need to "feel" stable, 
have a stable API (don't change command line arguments, don't change system 
requirements, etc.)

Is there an official list of what is and isn't allowed no.  What pseudo does is 
so specialized, I don't think I could come up with a documented set will and 
won't.  I also don't expect any applications to write such a list as in the end 
it is up to the contributors and maintainers to weigh each patch to determine if 
it feels appropriate to go on a stable branch.  But in practice I expect if 
someone using pseudo-1.9 experiences breakage due to security fixes in an 
existing platform release we'll backport the fixes there.  But I do not intend 
to carry forward pseudo-1.9 forever and into newer host releases.

So in short:

1. New Development goes to master (or equivalent)
2. Backports from master to a numbered branch can be requested
3. Priority for backports will be given to resolve breaking issues in known 
working hosts, generally centered around Yocto Project/OpenEmbedded as that is 
our primary test vehicle.
4. We do not intend API changes to be backported to older version.  (It's not a 
stronger statement, because with the security backports happening in 
distributions, it might be required at some point.)

--Mark

On 11/17/26 11:13 AM, Alexander Kanavin via openembedded-core wrote:
> On Tue, 17 Nov 2026 at 17:42, Yoann Congal via openembedded-core 
> <yoann.congal=smile.fr@lists.openembedded.org 
> <mailto:smile.fr@lists.openembedded.org>> wrote:
> 
> 
>     Pseudo now has a stable branch pseudo-1.9 with pseudo-1.9.x tags on it.
> 
> 
> Is this branch collecting only bugfixes (or fixes needed for continuing 
> operation of yocto release branches)? Is this going to be a policy for any 
> future point releases, or is it a one-off just for 1.9.x? There should be 
> confirmation of these questions, in addition to the existence of the branch.
> 
> Alex
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#250463): https://lists.openembedded.org/g/openembedded-core/message/250463
> Mute This Topic: https://lists.openembedded.org/mt/122316790/3616948
> Group Owner: openembedded-core+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/openembedded-core/unsub [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
