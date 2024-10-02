# compose2keybindings

This is a revision of [a script by Bob Kåres](http://bob.cakebox.net/osxcompose.php) written in [Perl](https://www.perl.org/) that ​converts a file containing [X11](https://www.x.org/wiki/) compose rules into a file containing the equivalent [Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html) key bindings. 

X11 compose rules can be used on Windows via [WinCompose](http://wincompose.info/). The Cocoa key bindings can be used on macOS via [Karabiner-Elements](https://karabiner-elements.pqrs.org/) on MacOS.

If you're not familiar with what WinCompose does on Windows, or don't want to be able to do what it does on your Mac too, then this repo is probably not for you!

If you simply want to use WinCompose on Mac and don't have any particular preferences about additional compose rules, then you can just go ahead and use mine, as discussed in the first step below.

# Usage

Five steps:
1. [Potentially skip a bunch of steps](#1-potentially-skip-a-bunch-of-steps)
1. [Setup your computer](#2-setup)
1. [Prepare your `.XCompose.txt` file](#3-prepare-your-xcomposetxt-file)
1. [Run the script](#4-run-the-script)
1. [Activate the key bindings](#4-activate-the-key-bindings)

## 1. Potentially skip a bunch of steps

If you're happy to use the rules I use, which include my opinionated attempt at incorporating them in with what I could cobble together to simulate the rules built in to WinCompose, then you can simply copy the file `DefaultKeyBinding.dict` from this repo into the `~/Library/KeyBindings/` directory, and skip straight over steps 2, 3, and 4, straight to step 5.

## 2. Setup your computer

I'll admit: I struggled to figure out how to run Bob's script. It's quite possible that absolutely none of the following steps I took were necessary for me to take, and/or won't be necessary for you to take. So if you're hopeful or in a hurry, I suggest you try your luck skipping straight to the [Running the script](#running-the-script) section below, and only refer to this record here of all the things I tried if you get stuck. One or all of them might make the difference. 

However it works out for you, if you find a moment, I'd be grateful to receive your experience report at douglas.blumeyer@gmail.com so that I can update these instructions. I'm too lazy now myself to figure out how to reset my environment to how it was before I took all these steps, and then reset it repeatedly, after each time trying this script from scratch but with different combinations of setup steps, until I isolate the ones that are actually necessary. 

1. Install [Homebrew](https://brew.sh/) if you don't have it yet. We'll need it to install some things: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
1. Install [XQuartz](https://www.xquartz.org/) if you don't have it yet. Using Homebrew: `brew install --cask xquartz`
1. Before running XQuartz, change some config: `sudo vi /etc/ssh/sshd_config` (and enter your Mac user password)
   1. Change `X11Forwarding` from `no` to `yes` and uncomment it by removing the leading `#`.
   1. Add the line `ForwardX11Trusted yes` somewhere.
1. Also run: `export DISPLAY=:0`
1. Now you're ready to run XQuartz for what we need to use it for. Open it.
1. Inside the XQuartz terminal, run `sudo cpan` (and enter your password again). Finally, inside [CPAN](https://www.cpan.org/), run the following three commands to install the libraries the script needs:
   1. `install X11:KeySyms`
      1. If you have errors installing this one, try [downloading](http://search.cpan.org/CPAN/authors/id/S/SM/SMCCAM/X11-Protocol-0.56.tar.gz) directly and running `perl Makefile.PL`, `make`, and `make install` after unzipping.
   1. `install List::MoreUtils`
   1. `install charnames`

Other than that, Perl comes pre-setup with macOS, so you should be good to go. 

## 3. Prepare your `.XCompose.txt` file

If you simply take your `.XCompose.txt` file containing your custom user compose rules and convert that over to key bindings, you'll soon discover that you're missing all of the compose rules that came built in to WinCompose. You'll want to add those into your `.XCompose.txt` file up top and then convert that. You should expect to deal with some intercepting rules and some conflicting rules, as I did. The script will give you nice error messages to help iron those out.

WinCompose no longer exposes its built-in rules. So actually, I couldn't simply directly include them in my `.XCompose.txt`, and neither can you. What I did was cobbled together whatever I could from the internet, and take my own opinionated pass at incorporating my custom rules in with that. You will probably have your own opinions on how to do this. So I put the raw stuff into a folder, `/builtInRulesRawMaterials`.

If you simply want to use WinCompose on Mac and don't have any additional compose rules, you'll still need to do this step of putting an `.XCompose.txt` together out of the raw files that WinCompose's built-in rules probably consist of.

## 4. Run the script

Here is the command you need to run in order to create the needed Cocoa key bindings file from your existing X11 compose rules file.

```sh
cat .XCompose.txt | perl compose2keybindings.pl > ~/Library/KeyBindings/DefaultKeyBinding.dict
```

This assumes:
* Your WinCompose custom compose rules file is named `.XCompose.txt` (per Sam's convention)
* The `compose2keybindings.pl` is the one downloaded from this repo.
* You run this command in a directory where these two files are both located. (If you've cloned this repo down and run this command straight away, it will use my own `.XCompose.txt` file sitting here.)

The output Cocoa key bindings file, named `DefaultKeyBinding.dict`, is automatically created in your user library (not your system library `/System/Library` or local library `/Library`) directory, under `~/Library/KeyBindings`. This is where it eventually needs to go anyway, in order to be picked up by Karabiner-Elements.

## 5. Activate the key bindings

Great! So you've placed your key bindings into `~/Library/KeyBindings` as `DefaultKeyBinding.dict`. But you're not done yet, if you want to actually _use_ them. You haven't simulated your compose key yet. That's what you need to do to activate these key bindings, i.e. to use them like compose rules.

I found Bob's script in an [online post](https://web.archive.org/web/20200622230501/http://lolengine.net/blog/2012/06/17/compose-key-on-os-x) by [Sam Hocevar](https://en.wikipedia.org/wiki/Sam_Hocevar), who (among other things) is the creator of WinCompose. That post is over a decade old at the time of this writing (evidenced by the link being via the [Internet Archive's Wayback Machine](https://archive.org/web/)) and so parts of it are out-of-date. For instance, the KeyRemap4MacBook program involved has since evolved into a program called Karabiner-Elements. 

The prinicple remains the same, though: Karabiner-Elements does the first half of simulating a compose key, by mapping one keyboard key to an incredibly obscure combination of keys, which in this case is <kbd>Shift</kbd> + <kbd>Control</kbd> + <kbd>F13</kbd>. And that's literally all we're using Karabiner-Elements for (though it clearly can do a lot more than that). Then this `DefaultKeyBinding.dict` file picks up the second half of simulating a compose key, by using that same obscure combination of three keys as its top-level key for every key binding. 

To set up Karabiner-Elements, simply download their installer .dmg and run the .pkg inside as is commonplace for Mac application installation. Then open it. In the left panel, you should see a list of tabs. Sadly, what we're doing doesn't qualify under `Simple Modifications`, since we're mapping one key to a key _combination_. So you'll have to select the `Complex Modifications` tab. Then click the `Add your own rule` button, and paste the following configuration in:

```json
{
    "description": "MacCompose",
    "manipulators": [
        {
            "from": {
                "key_code": "right_option",
                "modifiers": {
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "f13",
                    "modifiers": [
                        "left_shift",
                        "left_control"
                    ]
                }
            ],
            "type": "basic"
        }
    ]
}
```

This is nothing but a JSON adaptation for Karabiner-Elements of the XML configuration that Sam provided in that blog post for KeyRemap4MacBook. 

You're ready to go! You don't even need to restart your computer. All you need to do to test them out is open an unopen application (or close and re-open one that you already have open). The key bindings get loaded on an application by application basis, whenever the app is opened.

# Precedents / alternatives

## Mac-Ompose

[Mac-Ompose](https://github.com/jsarenik/Mac-Ompose), by Ján Sáreník: this project will let you accomplish basically the same thing as my project, and more automatically, which is pretty nice. It will install Karabiner-Elements for you, and place a decent key bindings file where it needs to go. So this may be more your speed if you're not looking to spend too much time on this. (By "decent" I mean that the final time WinCompose exposed its built-in rules, they were in two files, one for Xorg rules and one for XCompose rules, and the rules used by this project almost exactly match those from the Xorg rules, but don't include the XCompose rules at all.) Ján also appears to have revised Bob's script in some similar ways to how I revised it: he also made it [handle compose rules which insert multiple characters](#2-handle-compose-rules-which-insert-multiple-characters) and [handle compose rules which insert 5-digit Unicode characters](#3-handle-compose-rules-which-insert-5-digit-unicode-characters), but it looks like his script will still suffer from the other 9 issues I detail below.

## gen-compose

[gen-compose](https://github.com/Granitosaurus/macos-compose), by Bernardas Ališauskas (I can't help but notice that more people named in this README than not have accents on the letters in their name!): this approach uses [Python](https://www.python.org/) to install it. It also relies on Karabiner-Elements, but it's not clear whether it installs it for you (I haven't tried myself). This project asks you to learn a proprietary format for compose rules, written in [.yml](https://yaml.org/), which doesn't sound too appealing to me. If you have a ton of existing custom rules in X11, as I did, this only offers "experimental" support for converting those. 

## Keyboard Maestro

[This Reddit post](https://www.reddit.com/r/KeyboardLayouts/comments/wbexkm/comment/ii6pt2d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) claims that it's possible to use this program to achieve compose rules, via what it calls a ["typed string trigger"](https://wiki.keyboardmaestro.com/trigger/Typed_String). But this program looks like it can do a whole hell of a lot more than that, and looks daunting to dig into myself. Feel free to give a shot yourself.

## arrow-hands-keyboard-karabiner

[This project](https://github.com/gkovacs/arrow-hands-keyboard-karabiner) by Geza Kovacs uses the same `compose2keybindings.pl` script from Bob Kåres that I'm using, though makes no modifications to it. It also uses Karabiner-Elements but assumes you have it installed already. He's using the Perl script to convert compose rules from Linux (Ubuntu), but it's an X11 thing so it's the same deal as when they're on Windows.  

# About my compose rules

## Custom rules in collaboration with Dave Keenan

I had developed an admittedly intense compose rules file over the past several years of working with WinCompose, after my regular collaborator [Dave Keenan](https://dkeenan.com/) turned me onto it. Actually, he's done way more with it than I have, so most of the credit for these rules must be given to Dave.

## Built-in WinCompose rules

As explained above, I also needed to include all the rules that are built-in to WinCompose, or at least my best attempt at simulating them from materials cobbled across the internet (including old files in the WinCompose repo's history), since these rules are not directly available anymore out of the program, such as by exporting. Sam now embeds them into the .exe.

I had to make some mods to them to avoid conflicts; Sam had noted that they did conflict, and I ironed those out. 

## Deleted dead keys

I also deleted all the dead keys. Bob's script didn't handle those. Perhaps they don't work with key bindings. I see these are important to some languages, but I can't be bothered to figure it out.

## Included Mac-Ompose rules

I also included the extra rules that the Mac-Ompose project uses that weren't in the Xorg rules. 

## Included Kragen's rules

And I included the paren files from Kragen Javier Sitaker's XCompose project. The dotXCompose file there was almost identical to the xCompose file in the [final snapshot from the WinCompose repo](https://github.com/samhocevar/wincompose/commit/25477177bb3566d3482bd52140ccfb071ac36c8e#diff-df20d61e31338c7d0d081d67465b77778c3e9240ea21f42ca6fcca857fd780f4). Dave and I had already covered frakturs in our own way.

## Added "Advanced Unicode input"

One cool feature that WinCompose supports is "Advanced Unicode input", which lets you insert any Unicode symbol by its code point, preceded by <kbd>⎄</kbd><kbd>U</kbd> and followed by <kbd>Space</kbd>. This is really nice to have available sometimes. To simulate this feature on Mac with keybindings, we need to define one key binding for each code point! So that's what I did, all the way up through Unicode's [Basic Multilingual Plane (BMP)](https://en.wikipedia.org/wiki/Plane_(Unicode)#Basic_Multilingual_Plane).

This increases the number of key bindings by an order of magnitude. On my machine it doesn't seem to impact performance. But if you find otherwise, removing these (at the bottom) would be a good way to correct for that.

## Changed spelled-out special characters to special characters where I could

... e.g. `<at>` could become `<@>`. 

For purposes of this conversion, `<colon>` can become `<:>`, however, there is a bug in WinCompose which causes rules with `<:>` instead of `<colon>` to break, so I kept these as `<colon>`. 

# Revisions

I made many revisions to Bob's script in order for it to properly do its job.

1. [Do not silently ignore unrecognized keys, including all special characters](#1-do-not-silently-ignore-unrecognized-keys-including-all-special-characters)
1. [Handle compose rules which insert multiple characters](#2-handle-compose-rules-which-insert-multiple-characters)
1. [Handle compose rules which insert 5-digit Unicode characters](#3-handle-compose-rules-which-insert-5-digit-unicode-characters)
1. [Handle Cocoa modifier keys](#4-handle-cocoa-modifier-keys)
1. [Handle `>:` and `:"`](#5-handle--and)
1. [Automatically replace simulated compose key with the Shift+Control+F13 combination](#6-automatically-replace-simulated-compose-key-with-the-shiftcontrolf13-combination)
1. [Include user comments for individual rules](#7-include-user-comments-for-individual-rules)
1. [Silence harmless warnings](#8-silence-harmless-warnings)
1. [Error on intercepted compose rules](#9-error-on-intercepted-compose-rules)
1. [Include additional X11 Keysym groups](#10-include-additional-x11-keysym-groups)


Honestly, there were many issues with the parsing, I can't confidently claim that all my rules are making it across the conversion unscathed. I did at least run a check to see that I have the same count of input rules and output bindings.

Before we dig into these, I must give Bob a huge thanks. I will be gaving him a bit of a hard time here, but I certainly couldn't have done anything like this without his initial Perl script. 

I also wish to apologize to Bob and to any other coders fluent in Perl. I had never seen or written Perl before making these revisions. I worked extensively with [ChatGPT](https://chat.openai.com/) on these revisions.

## 1. Do not silently ignore unrecognized keys, including all special characters

Many keys in my compose rule key sequences — while they worked fine for Wincompose — were unrecognized by the existing script. These are all "special character" keys, such as `<#>`, `<!>`, and `<~>`. Unfortunately, rather than report these recognition failures, the existing script just silently left them out of the output key bindings file.

In order to recognize these special character keys, the script needed them to be spelled out according to their [X11 Keysym name](https://www.cl.cam.ac.uk/~mgk25/ucs/keysymdef.h). So instead of `<#>`, `<!>`, and `<~>`, it needed them as `<numbersign>`, `<exclam>`, and `<asciitilde>`, respectively. My revised script replaces `<#>` with `<numbersign>`, etc. as it parses your compose rules file.

These replacements are listed in `my %replace_map` toward the top of the script.

I didn't do a comprehensive replacement of every possibly problematic special character. I only knocked out all the ones that were in my personal compose rules file. So I may have missed some special characters that you use in yours. In that case, I have also revised the script so that it will report those missing characters as errors on the console where you run the script. You can fix your issues by adding new lines to `my %replace_map` following the pattern there. You can find the strings you need to replace them with in the [X11 Window System Protocol standard](https://www.cl.cam.ac.uk/~mgk25/ucs/keysymdef.h), by looking them up by their Unicode code point.

## 2. Handle compose rules which insert multiple characters

Bob's script silently assumed that all compose rules inserted only a single character; for any rules that were supposed to insert multiple characters, it instead created a key binding that inserted only the first, and did not warn me that it had done so. 

I had several compose rules that inserted a short sequence of characters, so I changed the script to handle them properly.

## 3. Handle compose rules which insert 5-digit Unicode characters

Basic [Unicode](https://home.unicode.org/) characters need only four hexadecimal digits in their code point, such as `U+F710`, but many of the more advanced Unicode characters that my compose rules inserted need five, such as `U+1D40A`. These fall outside Unicode's BMP, and therefore they are not directly supported in certain environments, which apparently include this Perl script and/or Cocoa key bindings. So instead here, we have to represent these 5-digit Unicodes by their "surrogate pair" in UTF-16. I revised the script to do this. 

## 4. Handle Cocoa modifier keys

In Cocoa key binding syntax, several characters are reserved as shorthands for modifier keys; for examples, we've already seen `^` for <kbd>Control</kbd> and `$` for <kbd>Shift</kbd> in our simulated compose key. There are three others: `@` for <kbd>Command</kbd>, `~` for <kbd>Option</kbd>, and `#` for <kbd>Keypad</kbd>. All five of these characters' Unicode code points therefore must be escaped to prevent them from being interpreted as these modifier keys. I revised the script to do this.

There is one additional character which needed to be escaped like this: `\`, because this is itself the escape character. 

To be clear, anywhere the script used to put `"\U005C"` in an attempt to represent `\`, it would not work. Instead it needs to put `"\\\U005C"`.

Thanks to [this comment on Sam's post](https://web.archive.org/web/20200622230501/http://lolengine.net/blog/2012/06/17/compose-key-on-os-x#comment-14) from user `asedano` for the hints I needed to fix this issue.

## 5. Handle `>:` and `:"`

Handled when the compose rule places the colon between the key sequence and result directly next to the closing `>` of the final key (without a space). In the case where there was no space in this position, despite this working fine for WinCompose, the Perl script would just silently skip the line. So the first line here would not work, but the second one would:

```
<Multi_key> <Multi_key> <Multi_key>: "⎄" U2384	# COMPOSITION SYMBOL (to represent compose key)
<Multi_key> <Multi_key> <Multi_key>	: "⎄" U2384	# COMPOSITION SYMBOL (to represent compose key)
```

I fixed this issue. The same problem was true on the other end, when there'd be no space between the colon and the quote beginning the results.

## 6. Automatically replace simulated compose key with full Shift+Control+F13 combination

In Sam's post, he calls to our attention that Bob's script generates a Cocoa key bindings file with plain old <kbd>F13</kbd> as the simulated compose key, while the recommended Karabiner-Elements setup uses the safer combination (more obscure and thus less likely to conflict with existing key combinations) of <kbd>Shift</kbd> + <kbd>Control</kbd> + <kbd>F13</kbd>. Well, as a convenience, so I don't have to remember to do this manually, I changed Bob's script so it uses `"^$\UF710"` instead of `"\UF710"` (where `^` is <kbd>Control</kbd> and `$` is <kbd>Shift</kbd>).

## 7. Include user comments for individual rules

The existing script did already provide comments for each key binding to help read at a glance what the keys in the sequence are as well as the characters inserted by the result. However, it relied on its ability to identify the characters to be inserted to do this automatically. Thus, compose rules such as the ones Dave and I were using for Sagittal notation, which use code points in [Private Use Areas](https://en.wikipedia.org/wiki/Private_Use_Areas) per [SMuFL](https://www.smufl.org/), were left without any indication of what they were (not helped by the fact that the symbols don't render in most applications that one would be looking at this `.dict` file through). So we needed to include the user's own original comments into the final comment. I made this so.

I also made sure that if two rules have the same key sequence and the same result, but different comments, both comments are included.

## 8. Silence harmless warnings

The other revisions like `no strict refs;` and `@events && ` were just to silence some apparently harmless warnings I was getting.

## 9. Error on intercepted compose rules

Suppose you defined the two rules:

```
<Multi_key> <3> <"> : "Ж" U0416 # CYRILLIC CAPITAL LETTER ZHE
<Multi_key> <3> <"> <e> : "ё" U0451 # CYRILLIC SMALL LETTER IO
```

The second rule would never do anything, because the first rule would always intercept it. The conventional solution to such problems is to make the first rule end with a <kbd>Space</kbd>, in order to differentiate it from the other rule, like so:

```
<Multi_key> <3> <"> <space> : "Ж" U0416 # CYRILLIC CAPITAL LETTER ZHE
```

When I revised the script to start carrying over user comments, the script began to crash when it would encounter intercepted rules. I realized that this was almost a feature, not a bug. When Dave and I designed our rules, we took care to prevent such interceptions. But apparently we missed a couple of them. Now we can use this script to catch them! At least, we can use it now that I revised it to deliver a helpful error message about the interception.

Additional logic was necessary to handle the case when the intercepting rule occurs in the input file _after_ the intercepted rule(s).

The script also now similarly errors if you define two compose rules with the same key sequence but different results. In WinCompose, newly applied rules simply override earlier defined rules. But when converting, I wanted to surface this behavior. You can just comment out this part of the code if you don't care about this and it's getting really tedious for you.

## 10. Include additional X11 Keysym groups

The compose rules built in to WinCompose included a group that isn't included in the [`X11::Keysyms` module](https://metacpan.org/pod/X11::Keysyms), despite being included in the X11 Window System Protocol" standard. I added them manually, and you can follow the pattern I set if you need to need to add more yourself (all revisions to the Perl code are marked with a comment including their revision number, so just search `# REVISION 10` and you'll find this one).

# Possible future features

## Include entire commented out lines

Sometimes we want to keep around old rules as comments to remind us of other things we considered. And it would be nice if those translated into the Cocoa key bindings file. But I haven't taken care of this yet. You'll notice how the X11 compose rules file is flat, but the Cocoa key bindings file is nested, which causes some re-ordering of the sequences, but that shouldn't make this too much of a problem, I hope; as long as the commented out lines remain sorted as they would be if they weren't commented out.

Mainly I'm worried about how to include the commented-out rules in the same structure as the non-commented-out rules, without messing with the logic of interception/conflicting rules. Also, the output logic would need to be changed, or some way to edit stuff that has already been output, since the commented out line would need to contain the final key of the sequence which starts the line but has already been output, in case it opened a new hash. Well, I spent a weekend afternoon on it, and I got most of the way there, but it was just getting too gnarly and making the code too disgusting, so I backed away. Just not worth it. Maybe if someone can write Perl fluently and wants to take a crack at it, please be my guest. 

I think that the tree structure of the key bindings file could actually be advantageous for understanding rules and their relations, so it would be nice if we could carry over commented-out rules into that structure.

## Tests

I suppose there should be some tests, e.g. to make sure some compose rules file (containing minimum reproducible examples of all happy paths and edge cases) maps to a snapshot key bindings file, so that new features like the above could be added without concern.
