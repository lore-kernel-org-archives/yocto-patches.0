Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.98])
 by mx.groups.io with SMTP id smtpd.web11.15493.1714047723689072080
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 05:22:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1ic4ptJYvHXO3SqQUGO1KcH0JkcqTiucvZJlgRa5Y4=;
 b=L+gVWQDOCtJwpgsDyPpLtw4sMydX6qOmo8c+wYm18cnHpGS+BsyBqIyn6k+Fza3ysw3IByG2QOb3B3MGoRva2MJ38RyFUrp5ebQNNQZ3gNzJ5q9zmBsTRkzspNMJTUCDIvuEfWv6kCREPzeYZo/r9wcKfbRc1oL0bV0iKLd0KHqgy3JOUy8S8oqRWPmHCU3BBkVaRBex0H8bpAQkW9NmVDYDez7qc/fVDrN9VRE6nTSWt+ymzBn0TBjPuwKoKK8p4p1Os6ynnMcUJiEAgKJHXySXmO0tC4xuSVY3eL1BfgGi7XrPA9QuXe8Juw7xhr4tGVs2dVOwclOr6Y6TYsZufA==
Message-ID: <9e5785d5-5c63-4467-bacd-6f0af89ca515@theobroma-systems.com>
Date: Thu, 25 Apr 2024 14:21:57 +0200
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] enable stored U-Boot environment
References: <20240411011638.12198-1-twoerner@gmail.com>
 <bb4b9d20-b71d-4907-9df4-e3fbdd07275a@theobroma-systems.com>
 <20240417141930.GA11714@localhost>
 <1d35ff20-9a01-42c9-b001-a7df1310e60c@theobroma-systems.com>
 <20240424174350.GA35393@localhost>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240424174350.GA35393@localhost>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Trevor,

On 4/24/24 19:43, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2024-04-18 @ 10:43:10 AM, Quentin Schulz wrote:
>> Hi Trevor,
>>
>> On 4/17/24 16:19, Trevor Woerner via lists.yoctoproject.org wrote:
>> [...]
>>>>
>>>>> +}
>>>>> +
>>>>> +do_deploy:append:rk-u-boot-env() {
>>>>> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut
>>>> -d'=' -f2)"
>>>>> +	mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o
>>>> ${WORKDIR}/u-boot.env
>>>>> +
>>>>> +	install -d ${DEPLOYDIR}
>>>>> +	install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
>>>> Just install at the top and then write the file directly to DEPLOYDIR? Or,
>>>> actually, create the file in do_compile if possible?
>>>
>>> But I want this file handled correctly by do_deploy when sstate is being used?
>>> So don't I need to do this in the do_deploy task?
>>>
>>
>> Not sure to follow what's the concern about sstate? do_deploy sstate
>> monitors everything in DEPLOYDIR so everything you install in there shall be
>> under sstate?
>>
>> For me do_deploy is for moving a file from one location to another, in
>> DEPLOYDIR, nothing else. Everything that involves compilation/configuration
>> is in do_compile/do_configure, so it's a bit odd to me to see a call to
>> mkenvimage in do_deploy.
>>
>> I guess you could have an issue with sstate if you use WORKDIR for
>> u-boot.env since this wouldn't be under do_compile's sstate? But then just
>> use ${B} for that instead?
>>
>> Can you tell me a bit more about your concern here, I'm not getting the big
>> picture yet :/
> 
> Firstly I want these files handled correctly by the oe-core U-Boot packaging
> so they get included in the image/sstate correctly.
> 

Using WORKDIR as a way to pass files between tasks is a terrible idea, 
WORKDIR isn't properly cleaned. However... this is an issue in the 
"upstream" U-Boot recipe, not something you can deal with in your 
bbappend, so let's ignore this issue here.

I'm also not entirely sure how the sstate works for do_compile... 
Couldn't find any sstate-indirs and sstate-outdirs for 
do_compile/do_install with bitbake-getvar or a quick check with grep. Do 
you have any idea how/where this is handled?

> Second, I'm pretty sure that anything you want inserted into a wic image (i.e.
> all the "--sourceparams=..." that are specified in the wks file) need to be placed in
> ${WORKDIR} for wic to find them when assembling the image. I might be wrong
> about this, or there might be other directories that are searched, but I do
> know that putting these artifacts in ${WORKDIR} will get them included in the
> wic file as expected.
> 

I hope you're wrong about this. wic is run as part of the image recipe. 
It should therefore not assume anything about the location of WORKDIR of 
the u-boot package recipe. The recommended way for exchanging data 
between recipes is to use either SYSROOT_DIRS (and DEPENDS) or DEPLOYDIR 
(and DEPLOY_DIR_IMAGE from the other recipe; + do_task[depends] += 
"recipea:do_deploy"), so I assume this is what's used by wic.

The `wic create` command called in do_image_wic (IMAGE_CMD:wic) seems to 
be trying to get data from three directories: IMAGE_ROOTFS, 
DEPLOY_DIR_IMAGE, STAGING_DATADIR (and BUILDDIR passed as an environment 
variable).

U-Boot upstream recipe takes fw_env.config from WORKDIR and puts it into 
DEPLOYDIR as part of the do_deploy task. Therefore, we need to put it 
there (WORKDIR) now, so that we don't mess with the current 
implementation of U-Boot recipe.

However I don't think there's a reason for putting u-boot.env into the 
WORKDIR before installing it into DEPLOYDIR.

> Thirdly, the default U-Boot environment is placed in "u-boot-initial-env" (a
> text file). Later "u-boot-initial-env" is converted into a U-Boot environment
> file (i.e. apparently it has a checksum prepended to it) via `mkenvimage`.
> If all of that takes place in do_compile(), then the user will never have an
> opportunity to inject any variables into the U-Boot environment before it is
> converted to its binary form. So by doing this operation in do_deploy(),
> it gives the user an opportunity to inject things between the creation of
> "u-boot-initial-env" in do_compile(), and it's conversion to its binary form
> (i.e. the form that is including into the wic image) in do_deploy().
> 
> I've had rauc working with my rockchip boards for about 5-6 months now, and I
> know when I put that together initially I wanted to inject extra variables
> during the build. I'll have to revisit whether or not I still need to do that,
> but even if I don't, doesn't mean it wouldn't be a nice feature for a user.
> 

Agreed that's a nice thing to have.

We could use a do_compile postfunc for the mkenvimage part though. And 
then you could always do_compile:append to modify u-boot-initial-env 
file before your postfunc to create the mkenvimage runs.

We could also simply have another variable called e.g. 
UBOOT_INITIAL_ENV_EXTRA_VARS whose content is added at the end of 
fw_env.config in the upstream recipe (or in your bbappend before calling 
mkenvimage). That would allow to extend it.

I think it'd make sense to add support for creating the u-boot env "fs" 
(via mkenvimage) to the upstream recipe as I see this as something 
people could reuse on other vendors?

Thanks for taking the time to list the reasons, I see better what you're 
attempting to do in this series now :)

Cheers,
Quentin
