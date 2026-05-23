<script>
    window.Pusher = Pusher;

    window.Echo = new Echo({
        broadcaster: "pusher",
        key: "{{ env('PUSHER_APP_KEY') }}",
        cluster: "{{ env('PUSHER_APP_CLUSTER') }}",
        forceTLS: true,
        authEndpoint: "{{ url('/broadcasting/auth') }}",
        auth: {
            headers: {
                "X-CSRF-TOKEN": document.querySelector('meta[name="csrf-token"]').content
            }
        }
    });
</script>
