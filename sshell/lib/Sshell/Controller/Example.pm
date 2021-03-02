package Sshell::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;

use Terminal;
use Terminal::Ascii2Html;
use JSON ();


# This action will render a template
sub index ($self) {

    $self->{ascii2html} = Terminal::Ascii2Html->new;

    my $log = $self->app->log;


    my $cmd = "/usr/bin/zsh";
    my $terminal = Terminal->new(
        cmd            => $cmd,
        on_row_changed => sub {
            my ($terminal, $row, $text) = @_;

            $text = $self->{ascii2html}->htmlify($text);

            my $message = JSON->new->encode(
                {type => 'row', row => $row, text => $text});
            $self->send($message);
        },
        on_cursor_move => sub {
            my ($terminal, $x, $y) = @_;

            my $message =
            JSON->new->encode({type => 'cursor', x => $x, y => $y});
            $self->send($message);
        },
        on_finished => sub {
            my $terminal = shift;

            $self->close;
        }
    );
    $self->on(
        message => sub {
            my ($self, $message) = @_;

            my $json = JSON->new;

            eval { $message = $json->decode($message); };
            return if !$message || $@;

            my $type = $message->{type};
            if ($type eq 'key') {
                my $buffer;

                my $code = $message->{code};

                $terminal->key($code);
            }
            elsif ($type eq 'action') {
                $terminal->move($message->{action});
            }
            else {
                warn "Unknown type '$type'";
            }
        }
    );

    $self->on(
        disconnect => sub {
        }
    );

    $terminal->start;



    # Render template "example/welcome.html.ep" with message
    $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}


1;
